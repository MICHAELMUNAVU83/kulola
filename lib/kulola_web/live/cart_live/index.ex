defmodule KulolaWeb.CartLive.Index do
  use KulolaWeb, :live_view
  import KulolaWeb.HomeComponents

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Your Cart | Kulola")
     |> assign(:cart_items, [])
     |> assign(:cart_loaded, false)}
  end

  @impl true
  def handle_event("cart_loaded", %{"items" => items}, socket) do
    {:noreply,
     socket
     |> assign(:cart_items, items)
     |> assign(:cart_loaded, true)}
  end

  @impl true
  def handle_event("remove_item", %{"key" => key}, socket) do
    {:noreply, push_event(socket, "remove-cart-item", %{key: key})}
  end

  @impl true
  def handle_event("update_quantity", %{"key" => key, "quantity" => qty}, socket) do
    qty = max(1, min(99, String.to_integer(to_string(qty))))
    {:noreply, push_event(socket, "update-cart-quantity", %{key: key, quantity: qty})}
  end

  defp total_price(items) do
    Enum.reduce(items, 0, fn item, acc ->
      acc + (item["price"] || 0) * (item["quantity"] || 1)
    end)
  end

  defp fmt(n), do: KulolaWeb.Format.price(n)

  @impl true
  def render(assigns) do
    ~H"""
    <div id="cart-page" class="min-h-screen bg-white" phx-hook="CartSync">
      <.navbar cart_items={@cart_items} collections={[]} />

      <div class="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8">
        <h1 class="mb-8 text-3xl font-bold text-gray-900">Your Cart</h1>

        <%= if not @cart_loaded do %>
          <!-- Loading skeleton -->
          <div class="space-y-4">
            <%= for _ <- 1..3 do %>
              <div class="h-24 animate-pulse rounded-xl bg-gray-100"></div>
            <% end %>
          </div>
        <% else %>
          <%= if @cart_items == [] do %>
            <!-- Empty cart -->
            <div class="flex flex-col items-center justify-center py-24 text-center">
              <svg
                class="h-20 w-20 text-gray-200"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="1"
                  d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"
                />
              </svg>
              <h2 class="mt-6 text-xl font-semibold text-gray-800">Your cart is empty</h2>
              <p class="mt-2 text-gray-500">Start adding some beautiful pieces to your cart.</p>
              <a
                href="/"
                class="mt-8 rounded-full bg-[#C8001F] px-8 py-3 text-sm font-medium text-white transition hover:bg-red-800"
              >
                Shop Now
              </a>
            </div>
          <% else %>
            <div class="grid gap-8 lg:grid-cols-3">
              <!-- Cart Items -->
              <div class="lg:col-span-2">
                <div class="space-y-4">
                  <%= for item <- @cart_items do %>
                    <div class="flex gap-4 rounded-xl border border-gray-100 bg-white p-4 shadow-sm">
                      <!-- Image -->
                      <div class="h-24 w-20 flex-shrink-0 overflow-hidden rounded-lg bg-gray-100">
                        <%= if item["image"] do %>
                          <img
                            src={item["image"]}
                            alt={item["name"]}
                            class="h-full w-full object-cover"
                          />
                        <% else %>
                          <div class="flex h-full items-center justify-center text-3xl">👗</div>
                        <% end %>
                      </div>
                      
    <!-- Details -->
                      <div class="flex flex-1 flex-col justify-between">
                        <div class="flex items-start justify-between gap-2">
                          <div>
                            <h3 class="font-semibold text-gray-900">{item["name"]}</h3>
                            <p class="mt-1 text-sm text-gray-500">
                              <%= if item["color"] do %>
                                <span>Colour: {item["color"]}</span>
                              <% end %>
                              <%= if item["size"] do %>
                                <span class="ml-2">Size: {item["size"]}</span>
                              <% end %>
                            </p>
                          </div>
                          <button
                            phx-click="remove_item"
                            phx-value-key={item["key"]}
                            class="text-gray-400 transition hover:text-red-500"
                            aria-label="Remove"
                          >
                            <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                d="M6 18L18 6M6 6l12 12"
                              />
                            </svg>
                          </button>
                        </div>

                        <div class="flex items-center justify-between">
                          <!-- Quantity -->
                          <div class="flex items-center gap-2 rounded-full border border-gray-200 px-3 py-1">
                            <button
                              phx-click="update_quantity"
                              phx-value-key={item["key"]}
                              phx-value-quantity={max(1, (item["quantity"] || 1) - 1)}
                              class="text-gray-600 hover:text-black"
                            >
                              −
                            </button>
                            <span class="w-6 text-center text-sm font-medium">
                              {item["quantity"] || 1}
                            </span>
                            <button
                              phx-click="update_quantity"
                              phx-value-key={item["key"]}
                              phx-value-quantity={(item["quantity"] || 1) + 1}
                              class="text-gray-600 hover:text-black"
                            >
                              +
                            </button>
                          </div>
                          
    <!-- Price -->
                          <span class="font-semibold text-gray-900">
                            KES {fmt((item["price"] || 0) * (item["quantity"] || 1))}
                          </span>
                        </div>
                      </div>
                    </div>
                  <% end %>
                </div>
              </div>
              
    <!-- Order Summary -->
              <div class="h-fit rounded-xl border border-gray-100 bg-gray-50 p-6 shadow-sm">
                <h2 class="mb-6 text-lg font-semibold text-gray-900">Order Summary</h2>

                <div class="space-y-3 text-sm">
                  <div class="flex justify-between text-gray-600">
                    <span>
                      Subtotal ({Enum.reduce(@cart_items, 0, fn i, acc ->
                        acc + (i["quantity"] || 1)
                      end)} items)
                    </span>
                    <span>KES {fmt(total_price(@cart_items))}</span>
                  </div>
                  <div class="flex justify-between text-gray-600">
                    <span>Shipping</span>
                    <span class="text-green-600">Free</span>
                  </div>
                  <div class="border-t border-gray-200 pt-3">
                    <div class="flex justify-between text-base font-semibold text-gray-900">
                      <span>Total</span>
                      <span>KES {fmt(total_price(@cart_items))}</span>
                    </div>
                  </div>
                </div>

                <a
                  href="/checkout"
                  class="mt-6 block w-full rounded-full bg-[#C8001F] py-3 text-center text-sm font-medium text-white transition hover:bg-red-800"
                >
                  Proceed to Checkout
                </a>
                <a
                  href="/"
                  class="mt-3 block text-center text-sm text-gray-500 underline-offset-2 hover:underline"
                >
                  Continue Shopping
                </a>
              </div>
            </div>
          <% end %>
        <% end %>
      </div>

      <.footer />
    </div>
    """
  end
end
