defmodule KulolaWeb.CustomerLive.Index do
  use KulolaWeb, :admin_live_view

  alias Kulola.Customers
  alias Kulola.Orders

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Customers")
     |> assign(:current_path, "/admin/customers")
     |> assign(:counts, %{pending_orders: Orders.count_pending()})
     |> assign(:search, "")
     |> assign(:customers, Customers.list_customers())}
  end

  @impl true
  def handle_event("search", params, socket) do
    q = Map.get(params, "value", Map.get(params, "q", ""))
    {:noreply,
     socket
     |> assign(:search, q)
     |> assign(:customers, Customers.list_customers(q))}
  end

  # ── Helpers ───────────────────────────────────────────────────────────────

  defp fmt(n), do: KulolaWeb.Format.price(n)

  defp initials(name) when is_binary(name) and name != "" do
    name
    |> String.split()
    |> Enum.take(2)
    |> Enum.map(&String.first/1)
    |> Enum.join()
    |> String.upcase()
  end

  defp initials(_), do: "?"

  defp avatar_color(email) when is_binary(email) do
    colors = [
      "bg-violet-500", "bg-blue-500", "bg-green-500", "bg-amber-500",
      "bg-rose-500", "bg-indigo-500", "bg-teal-500", "bg-orange-500"
    ]

    idx = :erlang.phash2(email, length(colors))
    Enum.at(colors, idx)
  end

  defp avatar_color(_), do: "bg-gray-400"

  defp format_date(dt) do
    Calendar.strftime(dt, "%d %b %Y")
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <!-- Header -->
      <div class="mb-6 flex items-center justify-between">
        <div>
          <p class="text-xs font-semibold uppercase tracking-widest text-gray-400">Commerce</p>
          <h1 class="mt-1 text-2xl font-bold text-gray-900">
            Customers
            <span class="ml-2 text-lg font-normal text-gray-400">({length(@customers)})</span>
          </h1>
        </div>
        <!-- Search -->
        <div class="relative flex items-center">
          <svg class="pointer-events-none absolute left-3.5 h-4 w-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
          <input
            type="text"
            placeholder="Search name, email, phone…"
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
            >
              <svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
              </svg>
            </button>
          <% end %>
        </div>
      </div>

      <!-- Customer grid -->
      <%= if @customers == [] do %>
        <div class="flex flex-col items-center justify-center rounded-2xl border border-gray-200 bg-white py-24 text-center shadow-sm">
          <div class="flex h-16 w-16 items-center justify-center rounded-full bg-gray-100 text-3xl">👤</div>
          <p class="mt-4 text-sm font-medium text-gray-500">No customers yet</p>
          <p class="mt-1 text-xs text-gray-400">Customers appear here once an order is marked as paid.</p>
        </div>
      <% else %>
        <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm">
          <table class="w-full">
            <thead>
              <tr class="border-b border-gray-100 bg-gray-50">
                <th class="px-5 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-400">Customer</th>
                <th class="px-5 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-400">Contact</th>
                <th class="px-5 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-400">Orders</th>
                <th class="px-5 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-400">Total Spent</th>
                <th class="px-5 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-gray-400">Since</th>
                <th class="px-5 py-3 text-right text-[11px] font-semibold uppercase tracking-wider text-gray-400"></th>
              </tr>
            </thead>
            <tbody>
              <%= for customer <- @customers do %>
                <tr
                  class="group border-b border-gray-100 transition-colors last:border-0 hover:bg-gray-50 cursor-pointer"
                  phx-click={JS.navigate("/admin/customers/#{customer.id}")}
                >
                  <!-- Avatar + Name -->
                  <td class="px-5 py-3.5">
                    <div class="flex items-center gap-3">
                      <div class={["flex h-9 w-9 flex-shrink-0 items-center justify-center rounded-full text-sm font-bold text-white", avatar_color(customer.email)]}>
                        {initials(customer.name)}
                      </div>
                      <div>
                        <p class="text-sm font-semibold text-gray-900">{customer.name}</p>
                      </div>
                    </div>
                  </td>

                  <!-- Contact -->
                  <td class="px-5 py-3.5">
                    <p class="text-sm text-gray-700">{customer.email}</p>
                    <%= if customer.phone not in [nil, ""] do %>
                      <p class="text-xs text-gray-400">{customer.phone}</p>
                    <% end %>
                  </td>

                  <!-- Orders count -->
                  <td class="px-5 py-3.5">
                    <span class="inline-flex items-center gap-1 rounded-full bg-gray-100 px-2.5 py-1 text-xs font-semibold text-gray-700">
                      {customer.order_count} {if customer.order_count == 1, do: "order", else: "orders"}
                    </span>
                  </td>

                  <!-- Total spent -->
                  <td class="px-5 py-3.5">
                    <span class="text-sm font-bold text-gray-900">KSH {fmt(customer.total_spent)}</span>
                  </td>

                  <!-- Since -->
                  <td class="px-5 py-3.5">
                    <span class="text-xs text-gray-400">{format_date(customer.inserted_at)}</span>
                  </td>

                  <!-- Arrow -->
                  <td class="px-5 py-3.5 text-right">
                    <span class="text-gray-300 transition group-hover:text-gray-600">
                      <svg class="inline h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                      </svg>
                    </span>
                  </td>
                </tr>
              <% end %>
            </tbody>
          </table>
        </div>
      <% end %>
    </div>
    """
  end
end
