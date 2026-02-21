defmodule KulolaWeb.OldProductLive.Index do
  use KulolaWeb, :live_view

  alias Kulola.Shop.DummyData
  import KulolaWeb.ProductComponents
  import KulolaWeb.HomeComponents

  @impl true
  def mount(%{"slug" => slug}, _session, socket) do
    product = DummyData.product_by_slug(slug)

    if is_nil(product) do
      {:ok,
       socket
       |> put_flash(:error, "Product not found")
       |> push_navigate(to: "/")}
    else
      related = DummyData.related_products(product.id, 4)
      selected_color = product.colors |> Enum.find(& &1.selected) || List.first(product.colors)
      selected_size = product.sizes |> Enum.find(& &1.available) || List.first(product.sizes)
      selected_color_id = selected_color && selected_color.id
      selected_size_id = selected_size && selected_size.name

      {:ok,
       socket
       |> assign(:page_title, "#{product.name} | Kulola")
       |> assign(:product, product)
       |> assign(:related_products, related)
       |> assign(:selected_color_id, selected_color_id)
       |> assign(:selected_size_id, selected_size_id)
       |> assign(:quantity, 1)
       |> assign(:main_image_index, 0)
       |> assign(:accordion_open, nil)}
    end
  end

  @impl true
  def handle_event("select_color", %{"id" => id}, socket) do
    {:noreply, assign(socket, :selected_color_id, id)}
  end

  @impl true
  def handle_event("select_size", %{"name" => name}, socket) do
    {:noreply, assign(socket, :selected_size_id, name)}
  end

  @impl true
  def handle_event("set_quantity", %{"quantity" => qty}, socket) do
    qty = max(1, min(99, String.to_integer(qty)))
    {:noreply, assign(socket, :quantity, qty)}
  end

  @impl true
  def handle_event("set_main_image", %{"index" => idx}, socket) do
    idx = String.to_integer(idx)
    max_idx = length(socket.assigns.product.gallery_images) - 1
    idx = max(0, min(idx, max_idx))
    {:noreply, assign(socket, :main_image_index, idx)}
  end

  @impl true
  def handle_event("toggle_accordion", %{"section" => section}, socket) do
    current = socket.assigns.accordion_open
    next = if current == section, do: nil, else: section
    {:noreply, assign(socket, :accordion_open, next)}
  end

  @impl true
  def handle_event("add_to_cart", _params, socket) do
    # Placeholder – no cart yet
    {:noreply,
     socket
     |> put_flash(:info, "Added to cart")}
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
    <div id="product-page" class="page-typography min-h-screen bg-white">
      <.navbar />
      <.product_detail
        product={@product}
        main_image_index={@main_image_index}
        selected_color_id={@selected_color_id}
        selected_size_id={@selected_size_id}
        quantity={@quantity}
      />
      <.product_accordions accordion_open={@accordion_open} />
      <.related_products_section products={@related_products} />
      <.contact_section />
      <.footer />
    </div>
    """
  end
end
