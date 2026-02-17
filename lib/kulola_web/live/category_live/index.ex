defmodule KulolaWeb.CategoryLive.Index do
  use KulolaWeb, :live_view

  alias Kulola.Shop.DummyData

  @impl true
  def mount(%{"slug" => slug}, _session, socket) do
    category = DummyData.category_by_slug(slug)

    if is_nil(category) do
      {:ok,
       socket
       |> put_flash(:error, "Category not found")
       |> push_navigate(to: "/")}
    else
      product_types = DummyData.collections()
      products = DummyData.products_for_category(slug)
      popular = DummyData.popular_products()

      {:ok,
       socket
       |> assign(:page_title, "#{category.name} | Kulola")
       |> assign(:category, category)
       |> assign(:product_types, product_types)
       |> assign(:selected_types, [slug])
       |> assign(:bestsellers, DummyData.bestsellers())
       |> assign(:filter_pill, "all")
       |> assign(:sort, "best_selling")
       |> assign(:products, products)
       |> assign(:popular_products, popular)
       |> assign(:filters_open, false)}
    end
  end

  @impl true
  def handle_event("toggle_product_type", %{"slug" => slug}, socket) do
    current = socket.assigns.selected_types
    next = if slug in current, do: List.delete(current, slug), else: [slug | current]
    {:noreply, assign(socket, :selected_types, next)}
  end

  @impl true
  def handle_event("set_filter_pill", %{"pill" => pill}, socket) do
    {:noreply, assign(socket, :filter_pill, pill)}
  end

  @impl true
  def handle_event("set_sort", %{"sort" => sort}, socket) do
    {:noreply, assign(socket, :sort, sort)}
  end

  @impl true
  def handle_event("toggle_filters", _params, socket) do
    {:noreply, assign(socket, :filters_open, !socket.assigns.filters_open)}
  end

  @impl true
  def handle_event("close_filters", _params, socket) do
    {:noreply, assign(socket, :filters_open, false)}
  end

  @impl true
  def handle_event("contact_submit", _params, socket) do
    {:noreply,
     socket
     |> put_flash(:info, "Thanks! We'll get back to you soon.")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id="category-page" class="page-typography min-h-screen bg-white" phx-hook="HomeReveal">
      <.promo_bar />
      <.navbar />
      <.category_hero category={@category} />
      <.category_main
        product_types={@product_types}
        selected_types={@selected_types}
        filter_pill={@filter_pill}
        sort={@sort}
        products={@products}
        popular_products={@popular_products}
        filters_open={@filters_open}
      />
      <.features />
      <.countdown />
      <.best_sellers bestsellers={@bestsellers} />
      <.contact_section />
      <.footer />
    </div>
    """
  end
end
