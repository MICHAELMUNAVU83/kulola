defmodule KulolaWeb.CheckoutLive.Index do
  use KulolaWeb, :live_view
  import KulolaWeb.HomeComponents

  alias Kulola.{DeliveryAreas, Orders, Paystack, Promotions}

  @slots ["10:00 AM – 12:00 PM", "12:00 PM – 2:00 PM", "2:00 PM – 4:00 PM", "4:00 PM – 6:00 PM"]
  @fields ~w(name email phone location_scope order_type delivery_area other_area estate building unit_number floor address delivery_instructions courier fitting_date fitting_time wants_additional additional_items)

  @impl true
  def mount(_params, _session, socket) do
    form =
      Map.new(@fields, &{&1, ""})
      |> Map.merge(%{
        "location_scope" => "nairobi",
        "order_type" => "fitting",
        "courier" => "Kulola delivery"
      })

    {:ok,
     assign(socket,
       page_title: "Checkout | Kulola's Closet",
       cart_items: [],
       cart_loaded: false,
       submitting: false,
       form_error: nil,
       promo_input: "",
       applied_promo: nil,
       promo_error: nil,
       form: form,
       areas: DeliveryAreas.list(true),
       slots: @slots
     )}
  end

  @impl true
  def handle_event("cart_loaded", %{"items" => items}, socket),
    do: {:noreply, assign(socket, cart_items: items, cart_loaded: true)}

  def handle_event("update_form", params, socket) do
    form = Map.merge(socket.assigns.form, Map.take(params, @fields))

    form =
      if form["location_scope"] == "outside_nairobi",
        do: Map.put(form, "order_type", "delivery"),
        else: form

    {:noreply, assign(socket, form: form, form_error: nil)}
  end

  def handle_event("update_promo_input", %{"value" => value}, socket),
    do: {:noreply, assign(socket, :promo_input, value)}

  def handle_event("remove_promo", _, socket),
    do: {:noreply, assign(socket, applied_promo: nil, promo_input: "", promo_error: nil)}

  def handle_event("remove_item", %{"key" => key}, socket),
    do: {:noreply, push_event(socket, "remove-cart-item", %{key: key})}

  def handle_event("update_quantity", %{"key" => key, "quantity" => quantity}, socket) do
    case Integer.parse(to_string(quantity)) do
      {qty, _} ->
        {:noreply,
         push_event(socket, "update-cart-quantity", %{key: key, quantity: max(1, min(99, qty))})}

      :error ->
        {:noreply, socket}
    end
  end

  def handle_event("apply_promo", _, socket) do
    case Promotions.validate_code(String.trim(socket.assigns.promo_input)) do
      {:ok, promo} -> {:noreply, assign(socket, applied_promo: promo, promo_error: nil)}
      {:error, reason} -> {:noreply, assign(socket, applied_promo: nil, promo_error: reason)}
    end
  end

  def handle_event("place_order", _, socket) do
    with :ok <- validate(socket.assigns), {:ok, order} <- create_order(socket.assigns) do
      if order.order_type == "fitting" do
        {:noreply,
         socket
         |> push_event("clear-cart", %{})
         |> push_navigate(to: ~p"/success?reference=#{order.reference}")}
      else
        case Paystack.initialize(order.email, order.total_amount, order.reference) do
          %{"authorization_url" => url} ->
            {:noreply, redirect(socket, external: url)}

          %{"error" => reason} ->
            {:noreply,
             assign(socket, submitting: false, form_error: "Payment setup failed: #{reason}")}

          _ ->
            {:noreply,
             assign(socket,
               submitting: false,
               form_error: "Payment setup failed. Please try again."
             )}
        end
      end
    else
      {:error, message} when is_binary(message) ->
        {:noreply, assign(socket, submitting: false, form_error: message)}

      {:error, changeset} ->
        {:noreply, assign(socket, submitting: false, form_error: changeset_error(changeset))}
    end
  end

  defp validate(%{cart_items: []}), do: {:error, "Your cart is empty."}

  defp validate(%{form: form}) do
    required =
      if form["order_type"] == "fitting",
        do: ~w(name email phone delivery_area address fitting_date fitting_time),
        else: ~w(name email phone delivery_area address)

    case Enum.find(required, &blank?(form[&1])) do
      nil ->
        validate_conditional_fields(form)

      field ->
        {:error, "Please complete #{String.replace(field, "_", " ")}."}
    end
  end

  defp validate_conditional_fields(form) do
    cond do
      not String.contains?(form["email"], "@") ->
        {:error, "Please enter a valid email address."}

      form["delivery_area"] == "Other" and blank?(form["other_area"]) ->
        {:error, "Please enter your delivery area."}

      form["order_type"] == "fitting" and form["wants_additional"] == "yes" and
          blank?(form["additional_items"]) ->
        {:error, "Please tell us which additional items to bring."}

      true ->
        :ok
    end
  end

  defp create_order(%{cart_items: items, form: form, applied_promo: promo}) do
    subtotal = subtotal(items)
    discount = if promo, do: Promotions.calc_discount(promo, subtotal), else: 0
    fee = delivery_fee(form)
    type = form["order_type"]

    area =
      if form["delivery_area"] == "Other", do: form["other_area"], else: form["delivery_area"]

    Orders.create_order(%{
      reference: Orders.generate_reference(),
      name: form["name"],
      email: form["email"],
      phone: form["phone"],
      address: form["address"],
      items: items,
      order_type: type,
      location_scope: form["location_scope"],
      delivery_area: area,
      estate: form["estate"],
      building: form["building"],
      unit_number: form["unit_number"],
      floor: form["floor"],
      delivery_instructions: form["delivery_instructions"],
      courier: form["courier"],
      fitting_date: blank_to_nil(form["fitting_date"]),
      fitting_time: blank_to_nil(form["fitting_time"]),
      additional_items:
        if(form["wants_additional"] == "yes", do: blank_to_nil(form["additional_items"])),
      delivery_fee: fee,
      discount_amount: discount,
      promo_code: if(promo, do: promo.code),
      total_amount: if(type == "fitting", do: fee, else: subtotal - discount + fee),
      status: if(type == "fitting", do: "fitting_requested", else: "pending")
    })
  end

  defp delivery_fee(form),
    do:
      case(Enum.find(DeliveryAreas.list(true), fn area -> area.name == form["delivery_area"] end),
        do: (
          %{fee: fee} -> fee
          nil -> 0
        )
      )

  defp subtotal(items),
    do: Enum.reduce(items, 0, &(&2 + (&1["price"] || 0) * (&1["quantity"] || 1)))

  defp total(assigns),
    do:
      subtotal(assigns.cart_items) -
        if(assigns.applied_promo,
          do: Promotions.calc_discount(assigns.applied_promo, subtotal(assigns.cart_items)),
          else: 0
        ) + delivery_fee(assigns.form)

  defp blank?(value), do: value in [nil, ""]
  defp blank_to_nil(value), do: if(blank?(value), do: nil, else: value)

  defp changeset_error(changeset),
    do:
      changeset.errors |> Enum.map(fn {k, {m, _}} -> "#{k}: #{m}" end) |> List.first() ||
        "Please check your details."

  defp fmt(value), do: KulolaWeb.Format.price(value)

  @impl true
  def render(assigns) do
    ~H"""
    <div id="checkout-page" class="min-h-screen bg-[#f9f9f7]" phx-hook="CartSync">
      <.navbar cart_items={@cart_items} collections={[]} />
      <main class="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
        <div class="mb-8">
          <a href="/cart" class="text-sm text-gray-500">← Back to cart</a>
          <h1 class="mt-2 font-serif text-3xl font-bold">How would you like your order?</h1>
          <p class="mt-2 text-gray-500">
            Choose fitting or delivery, and we’ll collect only the details we need.
          </p>
        </div>
        <div class="grid gap-8 lg:grid-cols-5">
          <form
            id="checkout-form"
            phx-submit="place_order"
            phx-change="update_form"
            class="space-y-6 lg:col-span-3"
          >
            <%= if @form_error do %>
              <div class="rounded-xl bg-red-50 px-4 py-3 text-sm text-red-700">{@form_error}</div>
            <% end %>
            <.card step="Step 1" title="Where are you located?">
              <div class="grid grid-cols-2 gap-3">
                <.choice
                  name="location_scope"
                  value="nairobi"
                  checked={@form["location_scope"] == "nairobi"}
                  label="Nairobi"
                /><.choice
                  name="location_scope"
                  value="outside_nairobi"
                  checked={@form["location_scope"] == "outside_nairobi"}
                  label="Outside Nairobi"
                />
              </div>
              <%= if @form["location_scope"] == "nairobi" do %>
                <h3 class="mt-6 text-sm font-semibold">Are you available for fitting?</h3>
                <div class="mt-3 grid grid-cols-2 gap-3">
                  <.choice
                    name="order_type"
                    value="fitting"
                    checked={@form["order_type"] == "fitting"}
                    label="Yes, I want to fit"
                  /><.choice
                    name="order_type"
                    value="delivery"
                    checked={@form["order_type"] == "delivery"}
                    label="No, deliver it"
                  />
                </div>
              <% else %>
                <div class="mt-5 rounded-xl bg-amber-50 p-4 text-sm text-amber-900">
                  <strong>Countrywide delivery:</strong> please allow up to 48 hours for dispatch.
                </div>
              <% end %>
            </.card>
            <.card step="Step 2" title="Your details">
              <div class="grid gap-4 sm:grid-cols-2">
                <.field name="name" label="Full name *" value={@form["name"]} /><.field
                  name="phone"
                  type="tel"
                  label="Phone number *"
                  value={@form["phone"]}
                />
                <div class="sm:col-span-2">
                  <.field name="email" type="email" label="Email address *" value={@form["email"]} />
                </div>
              </div>
            </.card>
            <.card
              step="Step 3"
              title={
                if @form["order_type"] == "fitting", do: "Fitting details", else: "Delivery details"
              }
            >
              <div class="grid gap-4 sm:grid-cols-2">
                <label class="block text-sm font-medium">
                  Area *<select
                    name="delivery_area"
                    class="mt-1.5 w-full rounded-xl border-gray-300"
                    required
                  ><option value="">Select an area</option><%= for area <- @areas do %><option
                      value={area.name}
                      selected={@form["delivery_area"] == area.name}
                    >{area.name}{if area.fee > 0, do: " - KES #{area.fee}"}</option><% end %></select>
                </label>
                <%= if @form["delivery_area"] == "Other" do %>
                  <.field name="other_area" label="Your area *" value={@form["other_area"]} />
                <% end %>
                <div class="sm:col-span-2">
                  <.field
                    name="address"
                    label="Exact location / delivery address *"
                    value={@form["address"]}
                  />
                </div>
                <%= if @form["order_type"] == "fitting" do %>
                  <.field
                    name="fitting_date"
                    type="date"
                    label="Preferred fitting date *"
                    value={@form["fitting_date"]}
                  />
                  <label class="block text-sm font-medium">
                    2-hour fitting window *<select
                      name="fitting_time"
                      class="mt-1.5 w-full rounded-xl border-gray-300"
                      required
                    ><option value="">Select a time</option><%= for slot <- @slots do %><option
                        value={slot}
                        selected={@form["fitting_time"] == slot}
                      >{slot}</option><% end %></select>
                  </label>
                  <div class="sm:col-span-2">
                    <p class="text-sm font-medium">Bring other items in your size?</p>
                    <div class="mt-2 flex gap-5">
                      <label>
                        <input
                          type="radio"
                          name="wants_additional"
                          value="yes"
                          checked={@form["wants_additional"] == "yes"}
                        /> Yes
                      </label>
                      <label>
                        <input
                          type="radio"
                          name="wants_additional"
                          value="no"
                          checked={@form["wants_additional"] != "yes"}
                        /> No
                      </label>
                    </div>
                  </div>
                  <%= if @form["wants_additional"] == "yes" do %>
                    <div class="sm:col-span-2">
                      <.textarea
                        name="additional_items"
                        label="What should we bring?"
                        value={@form["additional_items"]}
                        placeholder="e.g. Brown sweater, size 10"
                      />
                    </div>
                  <% end %>
                <% else %>
                  <.field name="estate" label="Estate" value={@form["estate"]} /><.field
                    name="building"
                    label="Apartment / office"
                    value={@form["building"]}
                  /><.field
                    name="unit_number"
                    label="House / office number"
                    value={@form["unit_number"]}
                  /><.field name="floor" label="Floor" value={@form["floor"]} />
                  <div class="sm:col-span-2">
                    <.field
                      name="courier"
                      label="Courier / delivery service"
                      value={@form["courier"]}
                    />
                  </div>
                  <div class="sm:col-span-2">
                    <.textarea
                      name="delivery_instructions"
                      label="Delivery instructions"
                      value={@form["delivery_instructions"]}
                      placeholder="Landmark or other useful details"
                    />
                  </div>
                <% end %>
              </div>
            </.card>
            <section class="rounded-2xl border bg-white p-6 shadow-sm">
              <h2 class="font-semibold">Promo code</h2>
              <div class="mt-3 flex gap-2">
                <input
                  type="text"
                  value={@promo_input}
                  phx-input="update_promo_input"
                  class="min-w-0 flex-1 rounded-xl border-gray-300"
                />
                <button
                  type="button"
                  phx-click="apply_promo"
                  class="rounded-xl border border-[#C8001F] px-5 text-[#C8001F]"
                >
                  Apply
                </button>
              </div>
              <%= if @promo_error do %>
                <p class="mt-2 text-xs text-red-600">{@promo_error}</p>
              <% end %>
              <%= if @applied_promo do %>
                <p class="mt-2 text-sm text-green-700">
                  {@applied_promo.code} applied · {@applied_promo.discount_percent}% off
                  <button type="button" phx-click="remove_promo" class="underline">Remove</button>
                </p>
              <% end %>
            </section>
            <button
              type="submit"
              disabled={@submitting or @cart_items == []}
              class="w-full rounded-full bg-[#C8001F] py-4 font-semibold text-white disabled:opacity-50"
            >
              {if @form["order_type"] == "fitting",
                do: "Submit fitting request →",
                else: "Continue to secure payment →"}
            </button>
          </form>
          <aside class="lg:col-span-2">
            <div class="sticky top-6 rounded-2xl border bg-white p-6 shadow-sm">
              <h2 class="font-semibold">Your order</h2>
              <div class="mt-4 divide-y">
                <%= for item <- @cart_items do %>
                  <div class="flex gap-3 py-4">
                    <%= if item["image"] do %>
                      <img src={item["image"]} class="h-16 w-14 rounded-lg object-cover" />
                    <% end %>
                    <div class="min-w-0 flex-1">
                      <p class="truncate text-sm font-semibold">{item["name"]}</p>
                      <p class="text-xs text-gray-500">
                        {item["size"]} · Qty {item["quantity"] || 1}
                      </p>
                    </div>
                    <span class="text-sm font-semibold">
                      KES {fmt((item["price"] || 0) * (item["quantity"] || 1))}
                    </span>
                  </div>
                <% end %>
              </div>
              <div class="space-y-2 border-t pt-4 text-sm">
                <div class="flex justify-between">
                  <span>Subtotal</span><span>KES {fmt(subtotal(@cart_items))}</span>
                </div>
                <div class="flex justify-between">
                  <span>Delivery / fitting fee</span><span>{if delivery_fee(@form) == 0, do: "To be confirmed", else: "KES #{fmt(delivery_fee(@form))}"}</span>
                </div>
                <div class="flex justify-between border-t pt-3 text-lg font-bold">
                  <span>{if @form["order_type"] == "fitting", do: "Fee due", else: "Total"}</span><span class="text-[#C8001F]">KES {fmt(if @form["order_type"] == "fitting", do: delivery_fee(@form), else: total(assigns))}</span>
                </div>
              </div>
              <p class="mt-5 rounded-xl bg-gray-50 p-3 text-xs leading-5">
                Delivery orders dispatch within 48 hours. Our team will follow up on fitting requests.
              </p>
            </div>
          </aside>
        </div>
      </main>
      <.footer />
    </div>
    """
  end

  attr :step, :string, required: true
  attr :title, :string, required: true
  slot :inner_block, required: true

  defp card(assigns) do
    ~H"""
    <section class="rounded-2xl border bg-white p-6 shadow-sm">
      <p class="text-xs font-bold uppercase tracking-widest text-[#C8001F]">{@step}</p>
      <h2 class="mb-4 mt-1 text-lg font-semibold">{@title}</h2>
      {render_slot(@inner_block)}
    </section>
    """
  end

  attr :name, :string, required: true
  attr :value, :string, required: true
  attr :checked, :boolean, default: false
  attr :label, :string, required: true

  defp choice(assigns) do
    ~H"""
    <label class={[
      "cursor-pointer rounded-xl border p-4 text-center text-sm font-semibold",
      if(@checked, do: "border-[#C8001F] bg-red-50 text-[#C8001F]", else: "border-gray-200")
    ]}>
      <input type="radio" name={@name} value={@value} checked={@checked} class="sr-only" />{@label}
    </label>
    """
  end

  attr :name, :string, required: true
  attr :label, :string, required: true
  attr :value, :string, default: ""
  attr :type, :string, default: "text"

  defp field(assigns) do
    ~H"""
    <label class="block text-sm font-medium">
      {@label}<input
        type={@type}
        name={@name}
        value={@value}
        class="mt-1.5 w-full rounded-xl border-gray-300"
      />
    </label>
    """
  end

  attr :name, :string, required: true
  attr :label, :string, required: true
  attr :value, :string, default: ""
  attr :placeholder, :string, default: ""

  defp textarea(assigns) do
    ~H"""
    <label class="block text-sm font-medium">
      {@label}<textarea
        name={@name}
        rows="3"
        placeholder={@placeholder}
        class="mt-1.5 w-full rounded-xl border-gray-300"
      >{@value}</textarea>
    </label>
    """
  end
end
