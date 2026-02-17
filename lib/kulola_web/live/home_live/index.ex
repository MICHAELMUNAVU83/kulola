defmodule KulolaWeb.HomeLive.Index do
  use KulolaWeb, :live_view

  alias Kulola.Shop.DummyData

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Home | Kulola")
     |> assign(:collections, DummyData.collections())
     |> assign(:products, DummyData.new_arrivals())
     |> assign(:bestsellers, DummyData.bestsellers())
     |> assign(:bundle_products, DummyData.bundle_products())
     |> assign(:testimonials, DummyData.testimonials())
     |> assign(:instagram_images, DummyData.instagram_images())
     |> assign(:sale_banner, DummyData.sale_banner())
     |> assign(:sale_banner_index, 0)
     |> assign(:marquee_items, DummyData.marquee_items())}
  end

  @impl true
  def handle_event("select_sale_slide", %{"index" => raw_index}, socket) do
    index = String.to_integer(raw_index)
    slides = socket.assigns.sale_banner.slides
    max_index = length(slides) - 1
    index = min(max(0, index), max_index)
    {:noreply, assign(socket, :sale_banner_index, index)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.navbar />
      <.hero />
      <.collections collections={@collections} />
      <.sale_banner sale_banner={@sale_banner} current_index={@sale_banner_index} />
      <.new_arrivals products={@products} />
      <.banner items={@marquee_items} />
      <.two_column_collection />
      <.video_banner />
      <.bundle_and_save bundle_products={@bundle_products} />
      <.testimonials testimonials={@testimonials} />
      <.best_sellers bestsellers={@bestsellers} />
      <.countdown />
      <.partners instagram_images={@instagram_images} />
    </div>
    """
  end
end
