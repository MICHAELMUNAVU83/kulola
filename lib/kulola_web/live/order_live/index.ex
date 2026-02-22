defmodule KulolaWeb.OrderLive.Index do
  use KulolaWeb, :admin_live_view

  alias Kulola.Orders

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Orders")
     |> assign(:current_path, "/admin/orders")
     |> assign(:counts, %{pending_orders: Orders.count_pending()})
     |> assign(:status_filter, "all")
     |> assign(:search, "")
     |> assign(:status_counts, Orders.count_by_status())
     |> assign(:orders, Orders.list_orders_filtered("all", ""))}
  end

  @impl true
  def handle_event("filter_status", %{"status" => status}, socket) do
    orders = Orders.list_orders_filtered(status, socket.assigns.search)

    {:noreply,
     socket
     |> assign(:status_filter, status)
     |> assign(:orders, orders)}
  end

  @impl true
  def handle_event("search", params, socket) do
    q = Map.get(params, "value", Map.get(params, "q", ""))
    orders = Orders.list_orders_filtered(socket.assigns.status_filter, q)
    {:noreply, socket |> assign(:search, q) |> assign(:orders, orders)}
  end

  @impl true
  def handle_event("update_status", %{"id" => id, "status" => status}, socket) do
    order = Orders.get_order!(id)

    case Orders.update_status(order, status) do
      {:ok, updated_order} ->
        orders =
          socket.assigns.orders
          |> Enum.map(fn o -> if o.id == updated_order.id, do: updated_order, else: o end)

        {:noreply,
         socket
         |> assign(:orders, orders)
         |> assign(:status_counts, Orders.count_by_status())
         |> assign(:counts, %{pending_orders: Orders.count_pending()})}

      {:error, _} ->
        {:noreply, put_flash(socket, :error, "Could not update order status.")}
    end
  end

  # ── Helpers ───────────────────────────────────────────────────────────────

  defp status_color(status) do
    case status do
      "pending" -> "bg-amber-50 text-amber-700"
      "paid" -> "bg-blue-50 text-blue-700"
      "processing" -> "bg-purple-50 text-purple-700"
      "shipped" -> "bg-indigo-50 text-indigo-700"
      "delivered" -> "bg-green-50 text-green-700"
      "cancelled" -> "bg-gray-100 text-gray-500"
      "failed" -> "bg-red-50 text-red-700"
      _ -> "bg-gray-100 text-gray-500"
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

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <!-- Header -->
      <div class="mb-6 flex items-center justify-between">
        <div>
          <p class="text-xs font-semibold uppercase tracking-widest text-gray-400">Commerce</p>
          <h1 class="mt-1 text-2xl font-bold text-gray-900">Orders</h1>
        </div>
        <!-- Search -->
        <div class="relative flex items-center">
          <svg class="pointer-events-none absolute left-3.5 h-4 w-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
          <input
            type="text"
            placeholder="Search reference, name, email…"
            value={@search}
            phx-input="search"
            phx-debounce="250"
            class="w-72 rounded-xl border border-gray-200 bg-white py-2.5 pl-10 pr-9 text-sm text-gray-700 shadow-sm placeholder-gray-400 focus:border-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-100"
          />
          <%= if @search != "" do %>
            <button
              phx-click="search"
              phx-value-value=""
              class="absolute right-3 text-gray-400 hover:text-gray-700"
              title="Clear search"
            >
              <svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
              </svg>
            </button>
          <% end %>
        </div>
      </div>

      <!-- Summary cards -->
      <div class="mb-6 grid grid-cols-2 gap-4 sm:grid-cols-4">
        <%= for {status, label, color, bg, icon} <- [
          {"paid",        "Paid",        "text-blue-700",   "bg-blue-50 border-blue-100",    "💳"},
          {"processing",  "Processing",  "text-purple-700", "bg-purple-50 border-purple-100","⚙️"},
          {"shipped",     "Shipped",     "text-indigo-700", "bg-indigo-50 border-indigo-100","🚚"},
          {"delivered",   "Delivered",   "text-green-700",  "bg-green-50 border-green-100",  "✅"}
        ] do %>
          <button
            phx-click="filter_status"
            phx-value-status={status}
            class={[
              "group rounded-xl border p-4 text-left shadow-sm transition hover:shadow-md",
              if(@status_filter == status, do: "ring-2 ring-gray-900 ring-offset-1 " <> bg, else: "bg-white border-gray-200")
            ]}
          >
            <div class="flex items-center justify-between">
              <p class="text-xs font-semibold uppercase tracking-widest text-gray-400">{label}</p>
              <span class="text-base">{icon}</span>
            </div>
            <p class={["mt-1 text-3xl font-bold tabular-nums", color]}>
              {Map.get(@status_counts, status, 0)}
            </p>
          </button>
        <% end %>
      </div>

      <!-- Status Tabs -->
      <div class="mb-5 flex gap-1 overflow-x-auto rounded-xl border border-gray-200 bg-white p-1 shadow-sm">
        <%= for tab <- [{"all", "All"}, {"paid", "Paid"}, {"processing", "Processing"}, {"shipped", "Shipped"}, {"delivered", "Delivered"}, {"cancelled", "Cancelled"}, {"failed", "Failed"}] do %>
          <% {key, label} = tab %>
          <% count = Map.get(@status_counts, key, 0) %>
          <button
            phx-click="filter_status"
            phx-value-status={key}
            class={[
              "flex items-center gap-1.5 whitespace-nowrap rounded-lg px-3 py-1.5 text-xs font-semibold transition",
              if(@status_filter == key,
                do: "bg-gray-900 text-white",
                else: "text-gray-500 hover:bg-gray-100 hover:text-gray-800"
              )
            ]}
          >
            {label}
            <%= if count > 0 do %>
              <span class={[
                "rounded-full px-1.5 py-0.5 text-[10px] font-bold tabular-nums",
                if(@status_filter == key, do: "bg-white/20 text-white", else: "bg-gray-100 text-gray-500")
              ]}>
                {count}
              </span>
            <% end %>
          </button>
        <% end %>
      </div>

      <!-- Orders Table -->
      <div class="overflow-hidden rounded-xl border border-gray-200 bg-white shadow-sm">
        <%= if @orders == [] do %>
          <div class="flex flex-col items-center justify-center py-20 text-center">
            <svg class="h-12 w-12 text-gray-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1"
                d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
            </svg>
            <p class="mt-4 text-sm font-medium text-gray-500">No orders found</p>
            <p class="mt-1 text-xs text-gray-400">Try changing the filter or search term.</p>
          </div>
        <% else %>
          <div class="overflow-x-auto">
            <table class="w-full">
              <thead>
                <tr class="border-b border-gray-100 bg-gray-50">
                  <th class="px-5 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-400">Reference</th>
                  <th class="px-5 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-400">Customer</th>
                  <th class="px-5 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-400">Items</th>
                  <th class="px-5 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-400">Total</th>
                  <th class="px-5 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-400">Status</th>
                  <th class="px-5 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-400">Date</th>
                  <th class="px-5 py-3 text-right text-[11px] font-semibold uppercase tracking-wider text-gray-400">Actions</th>
                </tr>
              </thead>
              <tbody>
                <%= for order <- @orders do %>
                  <tr
                    class="group border-b border-gray-100 transition-colors last:border-0 hover:bg-gray-50 cursor-pointer"
                    phx-click={JS.navigate("/admin/orders/#{order.id}")}
                  >
                    <td class="px-5 py-3.5">
                      <span class="font-mono text-xs font-semibold text-gray-900">{order.reference}</span>
                    </td>

                    <td class="px-5 py-3.5">
                      <p class="text-sm font-medium text-gray-900">{order.name}</p>
                      <p class="text-xs text-gray-400">{order.email}</p>
                    </td>

                    <td class="px-5 py-3.5">
                      <span class="text-sm text-gray-600">{item_count(order.items)} pcs</span>
                    </td>

                    <td class="px-5 py-3.5">
                      <span class="text-sm font-semibold text-gray-900">KSH {fmt(order.total_amount)}</span>
                    </td>

                    <td class="px-5 py-3.5">
                      <span class={[
                        "inline-flex items-center gap-1.5 rounded-full px-2.5 py-1 text-[11px] font-semibold capitalize",
                        status_color(order.status)
                      ]}>
                        <span class={["h-1.5 w-1.5 rounded-full", status_dot(order.status)]} />
                        {order.status}
                      </span>
                    </td>

                    <td class="px-5 py-3.5">
                      <span class="text-xs text-gray-400">{format_date(order.inserted_at)}</span>
                    </td>

                    <!-- Actions: quick status + open button -->
                    <td class="px-5 py-3.5" phx-click="">
                      <div class="flex items-center justify-end gap-1 opacity-0 transition-opacity group-hover:opacity-100">
                        <%= for next <- next_statuses(order.status) do %>
                          <button
                            phx-click="update_status"
                            phx-value-id={order.id}
                            phx-value-status={next}
                            class="rounded-lg border border-gray-200 px-2.5 py-1 text-[10px] font-semibold capitalize text-gray-600 transition hover:border-gray-900 hover:bg-gray-900 hover:text-white"
                            title={"Mark as #{next}"}
                          >
                            → {next}
                          </button>
                        <% end %>
                        <.link
                          navigate={"/admin/orders/#{order.id}"}
                          class="flex h-8 w-8 items-center justify-center rounded-lg border border-gray-200 text-gray-400 transition hover:border-gray-300 hover:text-gray-700"
                          title="View details"
                        >
                          <svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                          </svg>
                        </.link>
                      </div>
                    </td>
                  </tr>
                <% end %>
              </tbody>
            </table>
          </div>
        <% end %>
      </div>

    </div>
    """
  end
end
