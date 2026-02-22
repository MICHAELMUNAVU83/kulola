defmodule KulolaWeb.OrderLive.Show do
  use KulolaWeb, :admin_live_view

  alias Kulola.Orders

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Order")
     |> assign(:current_path, "/admin/orders")}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    order = Orders.get_order!(id)

    {:noreply,
     socket
     |> assign(:page_title, order.reference)
     |> assign(:order, order)
     |> assign(:counts, %{pending_orders: Orders.count_pending()})}
  end

  @impl true
  def handle_event("update_status", %{"status" => status}, socket) do
    order = socket.assigns.order

    case Orders.update_status(order, status) do
      {:ok, updated} ->
        msg =
          if status == "paid",
            do: "Order marked as paid. Stock deducted.",
            else: "Status updated to #{status}."

        {:noreply,
         socket
         |> assign(:order, updated)
         |> assign(:counts, %{pending_orders: Orders.count_pending()})
         |> put_flash(:info, msg)}

      {:error, _} ->
        {:noreply, put_flash(socket, :error, "Could not update order status.")}
    end
  end

  # ── Helpers ───────────────────────────────────────────────────────────────

  defp status_color(status) do
    case status do
      "pending" -> "bg-amber-50 text-amber-700 border-amber-200"
      "paid" -> "bg-blue-50 text-blue-700 border-blue-200"
      "processing" -> "bg-purple-50 text-purple-700 border-purple-200"
      "shipped" -> "bg-indigo-50 text-indigo-700 border-indigo-200"
      "delivered" -> "bg-green-50 text-green-700 border-green-200"
      "cancelled" -> "bg-gray-100 text-gray-500 border-gray-200"
      "failed" -> "bg-red-50 text-red-700 border-red-200"
      _ -> "bg-gray-100 text-gray-500 border-gray-200"
    end
  end

  defp status_dot(status) do
    case status do
      "pending" -> "bg-amber-400"
      "paid" -> "bg-blue-500"
      "processing" -> "bg-purple-500"
      "shipped" -> "bg-indigo-500"
      "delivered" -> "bg-green-500"
      "cancelled" -> "bg-gray-400"
      "failed" -> "bg-red-500"
      _ -> "bg-gray-400"
    end
  end

  defp next_statuses(current) do
    flow = %{
      "paid" => ["processing", "shipped", "cancelled"],
      "processing" => ["shipped", "cancelled"],
      "shipped" => ["delivered", "cancelled"],
      "delivered" => [],
      "cancelled" => [],
      "failed" => ["paid"]
    }

    Map.get(flow, current, [])
  end

  defp fmt(n), do: KulolaWeb.Format.price(n)

  defp format_date(dt) do
    Calendar.strftime(dt, "%d %b %Y, %H:%M")
  end

  defp item_count(items) when is_list(items) do
    Enum.reduce(items, 0, fn i, acc -> acc + (i["quantity"] || 1) end)
  end

  defp item_count(_), do: 0

  defp subtotal(items) when is_list(items) do
    Enum.reduce(items, 0, fn i, acc ->
      acc + (i["price"] || 0) * (i["quantity"] || 1)
    end)
  end

  defp subtotal(_), do: 0

  @impl true
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-7xl">

      <!-- Back button + header -->
      <div class="mb-6 flex items-center gap-4">
        <.link
          navigate="/admin/orders"
          class="flex h-9 w-9 items-center justify-center rounded-lg border border-gray-200 bg-white text-gray-400 shadow-sm transition hover:border-gray-300 hover:text-gray-700"
        >
          <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
          </svg>
        </.link>
        <div>
          <p class="text-xs font-semibold uppercase tracking-widest text-gray-400">Orders</p>
          <h1 class="mt-0.5 font-mono text-xl font-bold text-gray-900">{@order.reference}</h1>
        </div>
      </div>

      <div class="grid grid-cols-1 gap-6 lg:grid-cols-3">

        <!-- ── Left column: items + totals ── -->
        <div class="space-y-6 lg:col-span-2">

          <!-- Items -->
          <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm">
            <div class="border-b border-gray-100 px-6 py-4">
              <h2 class="text-sm font-semibold text-gray-900">
                Order Items <span class="ml-1 text-gray-400">({item_count(@order.items)})</span>
              </h2>
            </div>
            <div class="divide-y divide-gray-100">
              <%= for item <- (@order.items || []) do %>
                <div class="flex gap-4 px-6 py-4">
                  <div class="h-20 w-16 flex-shrink-0 overflow-hidden rounded-xl bg-gray-100">
                    <%= if item["image"] do %>
                      <img src={item["image"]} alt={item["name"]} class="h-full w-full object-cover" />
                    <% else %>
                      <div class="flex h-full items-center justify-center text-2xl">👗</div>
                    <% end %>
                  </div>
                  <div class="flex flex-1 flex-col justify-between min-w-0">
                    <div>
                      <p class="truncate text-sm font-semibold text-gray-900">{item["name"]}</p>
                      <% attrs = [item["color"], item["size"]] |> Enum.filter(&(&1 not in [nil, ""])) %>
                      <%= if attrs != [] do %>
                        <p class="mt-0.5 text-xs text-gray-400">{Enum.join(attrs, " · ")}</p>
                      <% end %>
                    </div>
                    <div class="flex items-center justify-between">
                      <span class="rounded-full bg-gray-100 px-2.5 py-0.5 text-xs font-medium text-gray-600">
                        Qty: {item["quantity"] || 1}
                      </span>
                      <span class="text-sm font-bold text-gray-900">
                        KSH {fmt((item["price"] || 0) * (item["quantity"] || 1))}
                      </span>
                    </div>
                  </div>
                </div>
              <% end %>
            </div>

            <!-- Totals -->
            <div class="border-t border-gray-100 bg-gray-50 px-6 py-4 space-y-2">
              <div class="flex justify-between text-sm text-gray-500">
                <span>Subtotal</span>
                <span>KSH {fmt(subtotal(@order.items))}</span>
              </div>
              <div class="flex justify-between text-sm text-gray-500">
                <span>Shipping</span>
                <span class="font-medium text-green-600">Free</span>
              </div>
              <div class="flex justify-between border-t border-gray-200 pt-2 text-base font-bold text-gray-900">
                <span>Total</span>
                <span>KSH {fmt(@order.total_amount)}</span>
              </div>
            </div>
          </div>

        </div>

        <!-- ── Right column: status + customer ── -->
        <div class="space-y-6">

          <!-- Status card -->
          <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm">
            <div class="border-b border-gray-100 px-5 py-4">
              <h2 class="text-sm font-semibold text-gray-900">Order Status</h2>
            </div>
            <div class="px-5 py-4 space-y-4">
              <span class={[
                "inline-flex items-center gap-2 rounded-full border px-3.5 py-1.5 text-sm font-semibold capitalize",
                status_color(@order.status)
              ]}>
                <span class={["h-2 w-2 rounded-full", status_dot(@order.status)]} />
                {@order.status}
              </span>

              <% nexts = next_statuses(@order.status) %>
              <%= if nexts != [] do %>
                <div class="space-y-2">
                  <p class="text-xs font-semibold uppercase tracking-widest text-gray-400">Move to</p>
                  <div class="flex flex-col gap-2">
                    <%= for next <- nexts do %>
                      <button
                        phx-click="update_status"
                        phx-value-status={next}
                        class={[
                          "rounded-xl border px-4 py-2.5 text-sm font-semibold capitalize transition",
                          case next do
                            "cancelled" ->
                              "border-red-200 bg-red-50 text-red-600 hover:bg-red-100"
                            "paid" ->
                              "border-green-200 bg-green-50 text-green-700 hover:bg-green-100"
                            _ ->
                              "border-gray-900 bg-gray-900 text-white hover:bg-gray-700"
                          end
                        ]}
                      >
                        <%= if next == "paid" do %>
                          ✓ Mark as Paid — deducts stock
                        <% else %>
                          Mark as {String.capitalize(next)} →
                        <% end %>
                      </button>
                    <% end %>
                  </div>
                </div>
              <% end %>

              <p class="text-xs text-gray-400">Placed on {format_date(@order.inserted_at)}</p>
            </div>
          </div>

          <!-- Customer card -->
          <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm">
            <div class="border-b border-gray-100 px-5 py-4">
              <h2 class="text-sm font-semibold text-gray-900">Customer</h2>
            </div>
            <div class="px-5 py-4 space-y-3 text-sm">
              <div class="flex items-start justify-between gap-3">
                <span class="text-gray-400 shrink-0">Name</span>
                <span class="font-medium text-gray-900 text-right">{@order.name}</span>
              </div>
              <div class="flex items-start justify-between gap-3">
                <span class="text-gray-400 shrink-0">Email</span>
                <a href={"mailto:#{@order.email}"} class="font-medium text-blue-600 hover:underline text-right break-all">
                  {@order.email}
                </a>
              </div>
              <%= if @order.phone not in [nil, ""] do %>
                <div class="flex items-start justify-between gap-3">
                  <span class="text-gray-400 shrink-0">Phone</span>
                  <span class="font-medium text-gray-900 text-right">{@order.phone}</span>
                </div>
              <% end %>
              <%= if @order.address not in [nil, ""] do %>
                <div class="flex items-start justify-between gap-3">
                  <span class="text-gray-400 shrink-0">Address</span>
                  <span class="font-medium text-gray-900 text-right">{@order.address}</span>
                </div>
              <% end %>
            </div>
          </div>

        </div>
      </div>
    </div>
    """
  end
end
