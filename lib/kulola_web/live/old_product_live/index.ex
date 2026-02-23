defmodule KulolaWeb.OldProductLive.Index do
  use KulolaWeb, :live_view

  alias Kulola.Shop
  import KulolaWeb.ProductComponents
  import KulolaWeb.HomeComponents

  @impl true
  def mount(%{"slug" => slug}, _session, socket) do
    product = Shop.get_product_by_slug(slug)

    if is_nil(product) do
      {:ok,
       socket
       |> put_flash(:error, "Product not found")
       |> push_navigate(to: "/")}
    else
      related = Shop.list_related_products(product.id, 4)
      selected_color = product.colors |> Enum.find(& &1.selected) || List.first(product.colors)
      selected_size = product.sizes |> Enum.find(& &1.available) || List.first(product.sizes)
      selected_color_id = selected_color && selected_color.id
      selected_size_id = selected_size && selected_size.name

      hero_images = Shop.list_hero_images(6)

      {:ok,
       socket
       |> assign(:page_title, product.name)
       |> assign(:meta_description, "#{String.slice(product.description || "", 0, 150)} — Shop #{product.name} at Kulola's Closet.")
       |> assign(:og_image, product.main_image || "/images/kulola-logo.png")
       |> assign(:product, product)
       |> assign(:related_products, related)
       |> assign(:selected_color_id, selected_color_id)
       |> assign(:selected_size_id, selected_size_id)
       |> assign(:quantity, 1)
       |> assign(:main_image_index, 0)
       |> assign(:accordion_open, nil)
       |> assign(:contact_images, Enum.shuffle(hero_images))
       |> assign(:nav_collections, Shop.list_collections_for_display())}
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
    %{product: product, selected_color_id: color_id, selected_size_id: size, quantity: qty} =
      socket.assigns

    color = Enum.find(product.colors, fn c -> c.id == color_id end)

    item = %{
      id: product.id,
      slug: product.slug,
      name: product.name,
      image: product.main_image,
      price: product.price,
      color: color && color.name,
      color_id: color_id,
      size: size,
      quantity: qty
    }

    {:noreply, push_event(socket, "add-to-cart", item)}
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
      <.navbar collections={@nav_collections} />
      <.product_detail
        product={@product}
        main_image_index={@main_image_index}
        selected_color_id={@selected_color_id}
        selected_size_id={@selected_size_id}
        quantity={@quantity}
      />
      <.product_accordions accordion_open={@accordion_open} product={@product} />
      <.related_products_section products={@related_products} />
      <.contact_section contact_images={@contact_images} />
      <.footer />
    </div>
    """
  end
end
