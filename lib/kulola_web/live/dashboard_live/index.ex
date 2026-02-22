defmodule KulolaWeb.DashboardLive.Index do
  use KulolaWeb, :admin_live_view

  alias Kulola.Orders
  alias Kulola.Customers
  alias Kulola.Repo
  alias Kulola.Products.Product
  alias Kulola.Collections.Collection

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Dashboard")
     |> assign(:current_path, "/admin")
     |> load_stats()
     |> load_charts()}
  end

  # ── Data loading ──────────────────────────────────────────────────────────

  defp load_stats(socket) do
    status_counts = Orders.count_by_status()

    socket
    |> assign(:total_revenue, Orders.total_revenue())
    |> assign(:total_orders, Orders.total_orders())
    |> assign(:total_customers, Customers.count_customers())
    |> assign(:avg_order_value, Orders.average_order_value())
    |> assign(:total_products, Repo.aggregate(Product, :count))
    |> assign(:total_collections, Repo.aggregate(Collection, :count))
    |> assign(:status_counts, status_counts)
    |> assign(:recent_orders, Orders.recent_orders(6))
  end

  defp load_charts(socket) do
    daily = Orders.daily_revenue(30)
    top_products = Orders.top_products_by_revenue(8)
    status_counts = socket.assigns.status_counts

    socket
    |> assign(:revenue_chart, build_revenue_chart(daily))
    |> assign(:status_chart, build_status_chart(status_counts))
    |> assign(:top_products_chart, build_top_products_chart(top_products))
  end

  # ── Chart builders ────────────────────────────────────────────────────────

  defp build_revenue_chart(daily) do
    labels = Enum.map(daily, fn {d, _} -> Calendar.strftime(d, "%d %b") end)
    values = Enum.map(daily, fn {_, v} -> v end)

    %{
      data: %{
        labels: labels,
        datasets: [
          %{
            label: "Revenue (KSH)",
            data: values,
            borderColor: "#111827",
            backgroundColor: "rgba(17,24,39,0.06)",
            fill: true,
            tension: 0.4,
            pointRadius: 3,
            pointBackgroundColor: "#111827",
            borderWidth: 2
          }
        ]
      }
    }
    |> Jason.encode!()
  end

  defp build_status_chart(status_counts) do
    statuses = ~w(paid processing shipped delivered cancelled failed)
    labels = Enum.map(statuses, &String.capitalize/1)
    values = Enum.map(statuses, &Map.get(status_counts, &1, 0))

    colors = %{
      "paid" => "#3b82f6",
      "processing" => "#8b5cf6",
      "shipped" => "#6366f1",
      "delivered" => "#22c55e",
      "cancelled" => "#9ca3af",
      "failed" => "#ef4444"
    }

    bg = Enum.map(statuses, &Map.get(colors, &1, "#e5e7eb"))

    %{
      data: %{
        labels: labels,
        datasets: [
          %{
            data: values,
            backgroundColor: bg,
            borderWidth: 0,
            hoverOffset: 6
          }
        ]
      },
      options: %{
        responsive: true,
        maintainAspectRatio: false,
        cutout: "70%",
        plugins: %{
          legend: %{
            display: true,
            position: "bottom",
            labels: %{boxWidth: 10, padding: 14, font: %{size: 11}}
          },
          tooltip: %{
            callbacks: %{}
          }
        }
      }
    }
    |> Jason.encode!()
  end

  defp build_top_products_chart(products) do
    labels = Enum.map(products, & &1.name)
    values = Enum.map(products, & &1.revenue)

    %{
      data: %{
        labels: labels,
        datasets: [
          %{
            label: "Revenue (KSH)",
            data: values,
            backgroundColor: "#111827",
            borderRadius: 4,
            barThickness: 14
          }
        ]
      }
    }
    |> Jason.encode!()
  end

  # ── Helpers ───────────────────────────────────────────────────────────────

  defp fmt(n), do: KulolaWeb.Format.price(n)

  defp status_color(status) do
    case status do
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
      "paid" -> "bg-blue-500"
      "processing" -> "bg-purple-500"
      "shipped" -> "bg-indigo-500"
      "delivered" -> "bg-green-500"
      "cancelled" -> "bg-gray-400"
      "failed" -> "bg-red-500"
      _ -> "bg-gray-400"
    end
  end

  defp format_date(dt), do: Calendar.strftime(dt, "%d %b %Y, %H:%M")

  defp item_count(items) when is_list(items) do
    Enum.reduce(items, 0, fn i, acc -> acc + (i["quantity"] || 1) end)
  end

  defp item_count(_), do: 0

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-6">

      <!-- Page header -->
      <div>
        <p class="text-xs font-semibold uppercase tracking-widest text-gray-400">Overview</p>
        <h1 class="mt-1 text-2xl font-bold text-gray-900">Dashboard</h1>
      </div>

      <!-- ── KPI Strip ── -->
      <div class="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-6">

        <div class="col-span-2 rounded-2xl border border-gray-200 bg-gray-900 p-5 text-white shadow-sm sm:col-span-1 lg:col-span-2">
          <p class="text-xs font-semibold uppercase tracking-widest text-gray-400">Total Revenue</p>
          <p class="mt-2 text-3xl font-bold tabular-nums">KSH {@total_revenue |> fmt()}</p>
          <p class="mt-1 text-xs text-gray-400">All confirmed orders</p>
        </div>

        <.kpi_card label="Orders" value={@total_orders} sub="confirmed" color="text-blue-600" />
        <.kpi_card label="Customers" value={@total_customers} sub="unique emails" color="text-violet-600" />
        <.kpi_card label="Avg. Order" value={"KSH #{fmt(@avg_order_value)}"} sub="per order" color="text-amber-600" />
        <.kpi_card label="Products" value={@total_products} sub="in catalogue" color="text-gray-700" />
        <.kpi_card label="Collections" value={@total_collections} sub="categories" color="text-gray-700" />
      </div>

      <!-- ── Charts row ── -->
      <div class="grid grid-cols-1 gap-6 lg:grid-cols-3">

        <!-- Revenue line chart (2/3 width) -->
        <div class="lg:col-span-2 rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
          <div class="mb-4 flex items-center justify-between">
            <div>
              <h2 class="text-sm font-semibold text-gray-900">Revenue — Last 30 Days</h2>
              <p class="text-xs text-gray-400">Daily totals from confirmed orders</p>
            </div>
            <span class="rounded-full bg-gray-100 px-3 py-1 text-xs font-semibold text-gray-600">
              KSH {fmt(@total_revenue)}
            </span>
          </div>
          <div class="h-56">
            <canvas
              id="revenue-chart"
              phx-hook="ChartHook"
              data-type="line"
              data-chart={@revenue_chart}
            />
          </div>
        </div>

        <!-- Status doughnut (1/3 width) -->
        <div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
          <div class="mb-4">
            <h2 class="text-sm font-semibold text-gray-900">Orders by Status</h2>
            <p class="text-xs text-gray-400">Distribution of confirmed orders</p>
          </div>
          <div class="h-56">
            <canvas
              id="status-chart"
              phx-hook="ChartHook"
              data-type="doughnut"
              data-chart={@status_chart}
            />
          </div>
        </div>

      </div>

      <!-- ── Bottom row ── -->
      <div class="grid grid-cols-1 gap-6 lg:grid-cols-3">

        <!-- Top products bar (2/3) -->
        <div class="lg:col-span-2 rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
          <div class="mb-4">
            <h2 class="text-sm font-semibold text-gray-900">Top Products by Revenue</h2>
            <p class="text-xs text-gray-400">Across all confirmed orders</p>
          </div>
          <div class="h-64">
            <canvas
              id="top-products-chart"
              phx-hook="ChartHook"
              data-type="bar"
              data-chart={@top_products_chart}
            />
          </div>
        </div>

        <!-- Recent orders list (1/3) -->
        <div class="rounded-2xl border border-gray-200 bg-white shadow-sm">
          <div class="border-b border-gray-100 px-5 py-4 flex items-center justify-between">
            <h2 class="text-sm font-semibold text-gray-900">Recent Orders</h2>
            <.link navigate="/admin/orders" class="text-xs font-semibold text-gray-400 hover:text-gray-700 transition">
              View all →
            </.link>
          </div>
          <div class="divide-y divide-gray-100">
            <%= if @recent_orders == [] do %>
              <p class="py-8 text-center text-sm text-gray-400">No orders yet.</p>
            <% else %>
              <%= for order <- @recent_orders do %>
                <.link navigate={"/admin/orders/#{order.id}"} class="flex items-center gap-3 px-5 py-3.5 hover:bg-gray-50 transition">
                  <div class="min-w-0 flex-1">
                    <p class="truncate font-mono text-xs font-semibold text-gray-900">{order.reference}</p>
                    <p class="truncate text-xs text-gray-400">{order.name} · {item_count(order.items)} items</p>
                  </div>
                  <div class="text-right flex-shrink-0">
                    <p class="text-xs font-bold text-gray-900">KSH {fmt(order.total_amount)}</p>
                    <span class={[
                      "inline-flex items-center gap-1 rounded-full px-1.5 py-0.5 text-[9px] font-semibold capitalize",
                      status_color(order.status)
                    ]}>
                      <span class={["h-1 w-1 rounded-full", status_dot(order.status)]} />
                      {order.status}
                    </span>
                  </div>
                </.link>
              <% end %>
            <% end %>
          </div>
          <%= if @recent_orders != [] do %>
            <div class="border-t border-gray-100 px-5 py-3 text-center">
              <p class="text-[11px] text-gray-400">{format_date(List.first(@recent_orders).inserted_at)} — latest</p>
            </div>
          <% end %>
        </div>

      </div>

      <!-- ── Status summary strip ── -->
      <div class="grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-6">
        <%= for {status, label} <- [
          {"paid", "Paid"},
          {"processing", "Processing"},
          {"shipped", "Shipped"},
          {"delivered", "Delivered"},
          {"cancelled", "Cancelled"},
          {"failed", "Failed"}
        ] do %>
          <.link
            navigate={"/admin/orders?status=#{status}"}
            class="rounded-xl border border-gray-200 bg-white p-3 text-center shadow-sm hover:shadow-md transition"
          >
            <p class="text-xs font-semibold uppercase tracking-widest text-gray-400">{label}</p>
            <p class={["mt-1 text-xl font-bold tabular-nums", status_dot_text(status)]}>
              {Map.get(@status_counts, status, 0)}
            </p>
          </.link>
        <% end %>
      </div>

    </div>
    """
  end

  # ── Sub-components ────────────────────────────────────────────────────────

  attr :label, :string, required: true
  attr :value, :any, required: true
  attr :sub, :string, default: ""
  attr :color, :string, default: "text-gray-900"

  defp kpi_card(assigns) do
    ~H"""
    <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm">
      <p class="text-xs font-semibold uppercase tracking-widest text-gray-400">{@label}</p>
      <p class={["mt-2 text-2xl font-bold tabular-nums", @color]}>{@value}</p>
      <p class="mt-1 text-xs text-gray-400">{@sub}</p>
    </div>
    """
  end

  defp status_dot_text(status) do
    case status do
      "paid" -> "text-blue-600"
      "processing" -> "text-purple-600"
      "shipped" -> "text-indigo-600"
      "delivered" -> "text-green-600"
      "cancelled" -> "text-gray-400"
      "failed" -> "text-red-500"
      _ -> "text-gray-700"
    end
  end
end
