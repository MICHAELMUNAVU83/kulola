defmodule KulolaWeb.HomeComponents do
  use Phoenix.Component
  use Gettext, backend: KulolaWeb.Gettext

  alias Kulola.Shop.DummyData
  alias Phoenix.LiveView.JS

  def navbar(assigns) do
    ~H"""
    <header class="border-b border-gray-200 bg-white">
      <div class="mx-auto flex max-w-7xl items-center justify-between px-4 py-4">
        <a href="/" class="text-xl font-bold text-gray-900 sm:text-2xl">Dojeen.</a>

        <nav class="hidden items-center gap-6 lg:flex lg:gap-8">
          <a href="/" class="text-sm font-medium text-gray-900 hover:text-gray-600">Home</a>

          <div class="relative">
            <button class="flex items-center gap-1 text-sm font-medium text-gray-600 hover:text-gray-900">
              Shop
              <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M19 9l-7 7-7-7"
                />
              </svg>
            </button>
          </div>

          <div class="relative">
            <button class="flex items-center gap-1 text-sm font-medium text-gray-600 hover:text-gray-900">
              Pages
              <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M19 9l-7 7-7-7"
                />
              </svg>
            </button>
          </div>

          <a href="/contact" class="text-sm font-medium text-gray-600 hover:text-gray-900">Contact</a>
        </nav>
        
    <!-- Right side: Search, Account, Cart -->
        <div class="flex items-center gap-2 sm:gap-4">
          <!-- Search - Icon on mobile, full input on desktop -->
          <button class="text-gray-600 hover:text-gray-900 lg:hidden">
            <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
              />
            </svg>
          </button>

          <div class="relative hidden lg:block">
            <input
              type="text"
              placeholder="Search products....."
              class="w-48 rounded-full border border-gray-300 bg-gray-50 py-2 pl-4 pr-10 text-sm placeholder-gray-400 focus:border-gray-400 focus:outline-none xl:w-64"
            />
            <button class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700">
              <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                />
              </svg>
            </button>
          </div>
          
    <!-- Account -->
          <button class="text-gray-600 hover:text-gray-900">
            <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="1.5"
                d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
              />
            </svg>
          </button>
          
    <!-- Cart -->
          <button class="flex items-center gap-1 text-gray-600 hover:text-gray-900 sm:gap-2">
            <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="1.5"
                d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"
              />
            </svg>
            <span class="hidden text-sm font-medium sm:inline">Cart</span>
          </button>
          
    <!-- Mobile Menu Button -->
          <button
            class="ml-2 text-gray-600 hover:text-gray-900 lg:hidden"
            phx-click={JS.toggle(to: "#mobile-menu")}
          >
            <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M4 6h16M4 12h16M4 18h16"
              />
            </svg>
          </button>
        </div>
      </div>
      
    <!-- Mobile Menu -->
      <div id="mobile-menu" class="hidden border-t border-gray-200 lg:hidden">
        <div class="space-y-1 px-4 py-4">
          <!-- Mobile Search -->
          <div class="relative mb-4">
            <input
              type="text"
              placeholder="Search products....."
              class="w-full rounded-full border border-gray-300 bg-gray-50 py-2 pl-4 pr-10 text-sm placeholder-gray-400 focus:border-gray-400 focus:outline-none"
            />
            <button class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-gray-700">
              <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                />
              </svg>
            </button>
          </div>
          
    <!-- Mobile Nav Links -->
          <a
            href="/"
            class="block rounded-lg px-3 py-2 text-base font-medium text-gray-900 hover:bg-gray-100"
          >
            Home
          </a>

          <button class="flex w-full items-center justify-between rounded-lg px-3 py-2 text-base font-medium text-gray-600 hover:bg-gray-100">
            Shop
            <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M19 9l-7 7-7-7"
              />
            </svg>
          </button>

          <button class="flex w-full items-center justify-between rounded-lg px-3 py-2 text-base font-medium text-gray-600 hover:bg-gray-100">
            Pages
            <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M19 9l-7 7-7-7"
              />
            </svg>
          </button>

          <a
            href="/contact"
            class="block rounded-lg px-3 py-2 text-base font-medium text-gray-600 hover:bg-gray-100"
          >
            Contact
          </a>
        </div>
      </div>
    </header>
    """
  end

  def hero(assigns) do
    ~H"""
    <section class="bg-white">
      <div class="grid min-h-[600px] lg:grid-cols-2">
        <!-- Left Content -->
        <div class="flex flex-col justify-center bg-[#f5f5f3] px-6 py-12 sm:px-12 lg:px-16 xl:px-24">
          <div class="flex items-center gap-3 text-xs font-semibold uppercase tracking-widest text-gray-600">
            <span class="h-px w-8 bg-gray-400"></span> SPRING 2025
          </div>

          <h1 class="mt-6 font-serif text-4xl font-bold italic leading-tight text-gray-900 sm:text-5xl lg:text-6xl">
            Quiet Luxury!<br />Timeless Form.
          </h1>

          <p class="mt-6 max-w-md text-base text-gray-600 sm:text-lg">
            Discover our latest collection where fluid design meets architectural precision. Each piece is crafted to move with you.
          </p>
          
    <!-- Stats -->
          <div class="mt-8 flex gap-12">
            <div>
              <p class="text-3xl font-bold text-gray-900 sm:text-4xl">40</p>
              <p class="text-sm text-gray-600">New Pieces</p>
            </div>
            <div>
              <p class="text-3xl font-bold text-gray-900 sm:text-4xl">100%</p>
              <p class="text-sm text-gray-600">Sustainable</p>
            </div>
          </div>
          
    <!-- Buttons -->
          <div class="mt-8 flex flex-wrap gap-4">
            <a
              href="/shop"
              class="rounded-full bg-gray-900 px-8 py-3 text-sm font-medium text-white transition hover:bg-gray-800"
            >
              Shop Now
            </a>
            <a
              href="/collection"
              class="rounded-full border-2 border-gray-900 px-8 py-3 text-sm font-medium text-gray-900 transition hover:bg-gray-900 hover:text-white"
            >
              View More
            </a>
          </div>
        </div>
        
    <!-- Right Image -->
        <div class="relative min-h-[400px] lg:min-h-full">
          <img
            src="/images/main.jpeg"
            alt="Spring collection model"
            class="absolute inset-0 h-full w-full object-cover"
          />
        </div>
      </div>
    </section>
    """
  end

  def collections(assigns) do
    ~H"""
    <section class="bg-white px-4 py-16 sm:px-6 lg:px-8 lg:py-24">
      <div class="mx-auto max-w-7xl">
        <!-- Header -->
        <div class="text-center">
          <p class="text-xs font-semibold uppercase tracking-widest text-gray-500">
            Fashion's Gallery
          </p>
          <h2 class="mt-3 font-serif text-3xl font-bold italic text-gray-900 sm:text-4xl lg:text-5xl">
            Explore Our Collections
          </h2>
        </div>
        
    <!-- Collection Cards -->
        <div class="mt-12 grid gap-4 sm:grid-cols-2 lg:grid-cols-5">
          <%= for {collection, index} <- Enum.with_index(@collections, 1) do %>
            <a
              href={collection.href}
              class="group relative flex min-h-[220px] flex-col justify-between rounded-xl border border-gray-200 bg-white p-5 transition-all hover:border-transparent hover:bg-[#e8dfd4] hover:shadow-lg"
            >
              <div>
                <span class="text-sm text-gray-400">{String.pad_leading("#{index}", 2, "0")}</span>
                <h3 class="mt-2 text-xl font-semibold text-gray-900">{collection.name}</h3>
              </div>

              <%= if collection.image do %>
                <div class="my-4 opacity-0 transition-opacity duration-200 group-hover:opacity-100">
                  <img
                    src={collection.image}
                    alt={collection.name}
                    class="h-20 w-16 rounded object-cover"
                  />
                </div>
              <% end %>

              <div class="flex items-center justify-between">
                <span class="text-sm text-gray-500">{collection.item_count} Items</span>
                <svg
                  class="h-5 w-5 text-gray-400 transition-transform group-hover:translate-x-1 group-hover:text-gray-900"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M17 8l4 4m0 0l-4 4m4-4H3"
                  />
                </svg>
              </div>
            </a>
          <% end %>
        </div>
      </div>
    </section>
    """
  end

  def sale_banner(assigns) do
    assigns =
      assigns
      |> assign_new(:current_index, fn -> 0 end)
      |> assign_new(:sale_banner, fn ->
        %{
          slides: [%{image: "/images/main.jpeg", alt: "Fashion"}],
          featured_product: %{}
        }
      end)

    ~H"""
    <% slides = Map.get(@sale_banner, :slides, []) %>
    <% current_slide =
      Enum.at(slides, @current_index) || %{image: "/images/main.jpeg", alt: "Fashion"} %>
    <section class="relative overflow-hidden bg-gray-100">
      <div class="grid lg:grid-cols-2">
        <!-- Left Content -->
        <div class="flex flex-col justify-center px-6 py-12 sm:px-12 lg:px-16 lg:py-24">
          <p class="text-xs font-semibold uppercase tracking-widest text-gray-500">
            Biggest Sale Offer
          </p>
          <h2 class="mt-4 font-serif text-3xl font-bold italic text-gray-900 sm:text-4xl lg:text-5xl">
            New & Modern Products<br class="hidden sm:block" /> in Our Online Store
          </h2>

          <a
            href="/shop"
            class="mt-8 w-fit rounded-full bg-gray-900 px-8 py-3 text-sm font-medium text-white transition hover:bg-gray-800"
          >
            Shop Now
          </a>
          
    <!-- Sale Tag -->
          <div class="mt-12 flex items-center gap-2 text-sm">
            <span class="text-gray-900">Midseason Sale</span>
            <span class="font-semibold text-red-500">25% Off!</span>
            <span class="text-gray-400">•</span>
            <span class="text-gray-600">Only</span>
            <a href="/sale" class="font-medium text-gray-900 underline">Selected Product</a>
          </div>
          
    <!-- Floating Product Card -->
          <div class="relative z-10 mt-8 lg:absolute lg:left-1/2 lg:top-1/2 lg:mt-0 lg:-translate-y-1/2 lg:translate-x-[-20%]">
            <div class="w-full max-w-xs rounded-xl bg-white p-4 shadow-xl sm:max-w-sm">
              <% product = Map.get(@sale_banner, :featured_product, %{}) %>
              <!-- Discount Badge -->
              <div class="relative">
                <%= if product[:badge] do %>
                  <span class="absolute left-2 top-2 rounded bg-red-500 px-2 py-1 text-xs font-semibold text-white">
                    {product[:badge]}
                  </span>
                <% end %>
                <img
                  src={product[:image] || "/images/main.jpeg"}
                  alt={product[:name] || "Featured"}
                  class="h-48 w-full rounded-lg object-contain sm:h-64"
                />
              </div>
              
    <!-- Color Options -->
              <div class="mt-4 flex gap-2">
                <%= for color <- product[:colors] || [] do %>
                  <button
                    class={"h-7 w-7 rounded-full border-2 #{if color[:selected], do: "border-gray-900", else: "border-transparent"} border-gray-300"}
                    style={"background-color: #{color[:hex]}"}
                  >
                  </button>
                <% end %>
              </div>

              <h3 class="mt-3 font-medium text-gray-900">{product[:name] || "Featured Product"}</h3>
              <div class="mt-1 flex items-center gap-2">
                <span class="text-lg font-semibold text-red-500">
                  $ {product[:price] && Decimal.to_string(product[:price])} USD
                </span>
                <%= if product[:original_price] do %>
                  <span class="text-sm text-gray-400 line-through">
                    ${product[:original_price] && Decimal.to_string(product[:original_price])} USD
                  </span>
                <% end %>
              </div>
            </div>
          </div>
        </div>
        
    <!-- Right Image (current slide) -->
        <div class="relative z-0 hidden min-h-[500px] lg:block">
          <img
            src={current_slide[:image]}
            alt={current_slide[:alt]}
            class="absolute inset-0 h-full w-full object-cover"
          />
          <!-- Slider Dots -->
          <div class="absolute right-6 top-1/2 flex -translate-y-1/2 flex-col gap-3">
            <%= for {_slide, index} <- Enum.with_index(slides) do %>
              <button
                type="button"
                phx-click="select_sale_slide"
                phx-value-index={index}
                class={"h-3 w-3 rounded-full transition-colors #{if index == @current_index, do: "bg-white", else: "border border-white/50 bg-transparent hover:bg-white/30"}"}
              >
              </button>
            <% end %>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def new_arrivals(assigns) do
    ~H"""
    <section class="bg-white px-4 py-16 sm:px-6 lg:px-8 lg:py-24">
      <div class="mx-auto max-w-7xl">
        <!-- Header -->
        <div class="text-center">
          <p class="text-xs font-semibold uppercase tracking-widest text-gray-500">New Arrivals</p>
          <h2 class="mt-3 font-serif text-3xl font-bold text-gray-900 sm:text-4xl lg:text-5xl">
            Modern & Trendy Styles<br />Just Arrived
          </h2>
        </div>
        
    <!-- Products Carousel -->
        <div class="relative mt-12">
          <!-- Nav Arrows -->
          <button class="absolute -left-4 top-1/2 z-10 hidden -translate-y-1/2 rounded-full border border-gray-200 bg-white p-3 shadow-sm transition hover:bg-gray-50 lg:block">
            <svg class="h-5 w-5 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M15 19l-7-7 7-7"
              />
            </svg>
          </button>

          <button class="absolute -right-4 top-1/2 z-10 hidden -translate-y-1/2 rounded-full border border-gray-200 bg-white p-3 shadow-sm transition hover:bg-gray-50 lg:block">
            <svg class="h-5 w-5 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
            </svg>
          </button>
          
    <!-- Product Grid -->
          <div class="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
            <%= for product <- @products do %>
              <div class="group">
                <!-- Image -->
                <div class="relative overflow-hidden rounded-lg bg-gray-100">
                  <%= if product.badge do %>
                    <span class={"absolute left-3 top-3 z-10 rounded px-2 py-1 text-xs font-semibold text-white #{if product.badge == "Sale", do: "bg-green-600", else: "bg-red-500"}"}>
                      {product.badge}
                    </span>
                  <% end %>
                  <img
                    src={product.main_image}
                    alt={product.name}
                    class="aspect-[3/4] w-full object-cover transition-transform duration-300 group-hover:scale-105"
                  />
                </div>
                
    <!-- Color Swatches -->
                <div class="mt-4 flex gap-2">
                  <%= for color <- product.colors do %>
                    <button
                      class={"h-6 w-6 rounded-full border-2 #{if color.selected, do: "border-gray-900", else: "border-transparent"}"}
                      style={"background-color: #{color.hex}"}
                    >
                    </button>
                  <% end %>
                </div>
                
    <!-- Product Info -->
                <h3 class="mt-3 text-sm font-medium text-gray-900">{product.name}</h3>
                <div class="mt-1 flex items-center gap-2">
                  <span class={"font-semibold #{if product.original_price, do: "text-red-500", else: "text-gray-900"}"}>
                    $ {product.price} USD
                  </span>
                  <%= if product.original_price do %>
                    <span class="text-sm text-gray-400 line-through">
                      ${product.original_price} USD
                    </span>
                  <% end %>
                </div>
              </div>
            <% end %>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def banner(assigns) do
    assigns = assign_new(assigns, :items, fn -> DummyData.marquee_items() end)

    ~H"""
    <section id="banner-marquee" class="overflow-hidden border-y border-gray-100 bg-white py-4" phx-hook="Marquee">
      <div data-marquee-track class="animate-marquee flex shrink-0 whitespace-nowrap">
        <div data-marquee-segment class="flex shrink-0 items-center gap-8 px-4">
          <%= for item <- @items do %>
            <div class="flex shrink-0 items-center gap-3">
              <span class="text-2xl">{item.icon}</span>
              <span class="text-sm font-medium text-gray-700">{item.text}</span>
            </div>
          <% end %>
        </div>
      </div>
    </section>
    """
  end

  def two_column_collection(assigns) do
    ~H"""
    <section class="bg-white px-4 py-16 sm:px-6 lg:px-8">
      <div class="mx-auto grid max-w-7xl gap-6 lg:grid-cols-2">
        <!-- Card 1 -->
        <%= for _collection <- [1,2] do %>
          <div class="group flex flex-col overflow-hidden  bg-gray-100 sm:flex-row">
            <div class="flex flex-1 flex-col justify-center p-8 sm:p-10">
              <p class="text-xs font-semibold uppercase tracking-widest text-gray-500">
                New Collection
              </p>
              <h3 class="mt-4 text-2xl font-bold text-gray-900 sm:text-3xl">
                ElegantDesign<br />Dress
              </h3>
              <a
                href="/collection/elegant"
                class="mt-6 flex h-12 w-12 items-center justify-center rounded-full border border-gray-300 transition hover:border-gray-900 hover:bg-gray-900 hover:text-white"
              >
                <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M7 17L17 7M17 7H7M17 7v10"
                  />
                </svg>
              </a>
            </div>
            <div class="relative h-[300px] flex-1 sm:min-h-0">
              <img
                src="/images/main.jpeg"
                alt="Elegant dress"
                class="absolute inset-0 h-full w-full object-cover"
              />
            </div>
          </div>
        <% end %>
      </div>
    </section>
    """
  end

  def video_banner(assigns) do
    ~H"""
    <section class="relative mx-4 my-8 overflow-hidden rounded-3xl sm:mx-6 lg:mx-8">
      <!-- Video Background -->
      <div class="relative min-h-[500px] sm:min-h-[600px] lg:min-h-[700px]">
        <video
          id="hero-video"
          class="absolute inset-0 h-full w-full object-cover"
          poster="/images/main.jpeg"
          muted
          loop
          playsinline
        >
          <source src="/images/video.mp4" type="video/mp4" />
        </video>
        
    <!-- Overlay -->
        <div class="absolute inset-0 bg-black/30"></div>
        
    <!-- Content -->
        <div class="relative flex h-full min-h-[500px] flex-col items-center justify-center px-6 text-center sm:min-h-[600px] lg:min-h-[700px]">
          <p class="text-xs font-semibold uppercase tracking-widest text-white/80">
            Up to 25% Off Sale
          </p>
          <h2 class="mt-4 text-3xl font-bold text-white sm:text-4xl lg:text-5xl">
            Best Fashion<br />Store Available to<br />Everyone!
          </h2>
          <a
            href="/collection"
            class="mt-6 text-sm font-medium text-white underline underline-offset-4 hover:text-white/80"
          >
            Shop Collection
          </a>
          
    <!-- Play/Pause Button -->
          <button
            id="video-toggle"
            phx-click={JS.dispatch("toggle-video")}
            class="mt-10 flex h-16 w-16 items-center justify-center rounded-full bg-white text-gray-900 shadow-lg transition hover:scale-105 sm:h-20 sm:w-20"
          >
            <svg id="pause-icon" class="h-6 w-6 sm:h-8 sm:w-8" fill="currentColor" viewBox="0 0 24 24">
              <path d="M6 4h4v16H6V4zm8 0h4v16h-4V4z" />
            </svg>
            <svg
              id="play-icon"
              class="hidden h-6 w-6 sm:h-8 sm:w-8"
              fill="currentColor"
              viewBox="0 0 24 24"
            >
              <path d="M8 5v14l11-7z" />
            </svg>
          </button>
        </div>
      </div>
    </section>
    """
  end

  def bundle_and_save(assigns) do
    ~H"""
    <section class="bg-white px-4 py-16 sm:px-6 lg:px-8 lg:py-24">
      <div class="mx-auto max-w-7xl">
        <!-- Header -->
        <div class="text-center">
          <p class="text-xs font-semibold uppercase tracking-widest text-gray-500">Bundle & Save</p>
          <h2 class="mt-3 font-serif text-3xl font-bold text-gray-900 sm:text-4xl lg:text-5xl">
            Build Your Product Bundle<br />& Save Money
          </h2>
        </div>
        
    <!-- Content Grid -->
        <div class="mt-12 rounded-2xl border border-gray-200 p-6 lg:p-8">
          <div class="grid gap-8 lg:grid-cols-3">
            <!-- Products Grid (2 columns) -->
            <div class="grid gap-6 sm:grid-cols-2 lg:col-span-2">
              <%= for product <- @bundle_products do %>
                <div class="group">
                  <div class="overflow-hidden rounded-lg bg-gray-100">
                    <img
                      src={product.main_image}
                      alt={product.name}
                      class="aspect-square w-full object-contain p-4 transition-transform group-hover:scale-105"
                    />
                  </div>
                  <div class="mt-4 border-t border-gray-200 pt-4">
                    <!-- Color Swatches -->
                    <div class="flex gap-2">
                      <%= for color <- product.colors do %>
                        <button
                          class={"h-6 w-6 rounded-full border-2 #{if color.selected, do: "border-gray-900", else: "border-transparent"}"}
                          style={"background-color: #{color.hex}"}
                        >
                        </button>
                      <% end %>
                    </div>
                    <h3 class="mt-3 text-sm font-medium text-gray-900">{product.name}</h3>
                    <p class="mt-1 font-semibold text-gray-900">$ {product.price} USD</p>
                  </div>
                </div>
              <% end %>
            </div>
            
    <!-- Featured Image -->
            <div class="hidden lg:block">
              <img
                src="/images/bundle-hero.jpg"
                alt="Bundle collection"
                class="h-full w-full rounded-lg object-cover"
              />
            </div>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def testimonials(assigns) do
    ~H"""
    <section class="bg-gray-50 px-4 py-16 sm:px-6 lg:px-8 lg:py-24">
      <div class="mx-auto max-w-7xl">
        <!-- Header -->
        <div class="text-center">
          <p class="text-xs font-semibold uppercase tracking-widest text-gray-500">Testimonial</p>
          <h2 class="mt-3 font-serif text-3xl font-bold text-gray-900 sm:text-4xl lg:text-5xl">
            Customer Feedback
          </h2>
        </div>
        
    <!-- Testimonials Carousel -->
        <div class="mt-12 flex gap-6 overflow-x-auto pb-4 snap-x snap-mandatory scrollbar-hide">
          <%= for testimonial <- @testimonials do %>
            <% rating_float = Decimal.to_float(testimonial.rating) %>
            <% full_stars = trunc(rating_float) %>
            <% has_half = rating_float - full_stars >= 0.5 %>

            <div class="min-w-[300px] max-w-md flex-shrink-0 snap-center rounded-2xl bg-white p-6 shadow-sm sm:min-w-[400px]">
              <!-- Rating -->
              <div class="flex items-center gap-2">
                <div class="flex text-yellow-400">
                  <%= for _i <- 1..full_stars do %>
                    <svg class="h-5 w-5 fill-current" viewBox="0 0 20 20">
                      <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z" />
                    </svg>
                  <% end %>
                  <%= if has_half do %>
                    <svg class="h-5 w-5 fill-current" viewBox="0 0 20 20">
                      <defs>
                        <linearGradient id={"half-#{testimonial.id}"}>
                          <stop offset="50%" stop-color="currentColor" />
                          <stop offset="50%" stop-color="#E5E7EB" />
                        </linearGradient>
                      </defs>
                      <path
                        fill={"url(#half-#{testimonial.id})"}
                        d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"
                      />
                    </svg>
                  <% end %>
                </div>
                <span class="text-sm text-gray-500">({testimonial.rating})</span>
              </div>
              
    <!-- Author -->
              <div class="mt-4 flex items-center gap-2">
                <h4 class="font-semibold text-gray-900">{testimonial.name}</h4>
                <span class="text-gray-400">—</span>
                <span class="text-sm text-gray-500">{testimonial.role}</span>
              </div>
              
    <!-- Content -->
              <p class="mt-4 text-gray-600">{testimonial.content}</p>
              
    <!-- Customer Image -->
              <div class="mt-6 flex justify-end">
                <img
                  src={testimonial.avatar}
                  alt={testimonial.name}
                  class="h-24 w-20 rounded-lg object-cover"
                />
              </div>
              
    <!-- Product Referenced -->
              <div class="mt-4 flex items-center gap-3 rounded-lg bg-gray-50 p-3">
                <img
                  src={testimonial.product.image}
                  alt={testimonial.product.name}
                  class="h-12 w-10 rounded object-cover"
                />
                <div>
                  <p class="text-sm font-medium text-gray-900">{testimonial.product.name}</p>
                  <p class="text-sm text-gray-600">$ {testimonial.product.price} USD</p>
                </div>
              </div>
            </div>
          <% end %>
        </div>
      </div>
    </section>
    """
  end

  def best_sellers(assigns) do
    ~H"""
    <section class="bg-white px-4 py-16 sm:px-6 lg:px-8 lg:py-24">
      <div class="mx-auto max-w-7xl">
        <div class="grid gap-8 lg:grid-cols-3">
          <!-- Left Promo Card -->
          <div class="flex flex-col justify-between rounded-2xl bg-gray-100 p-8 lg:row-span-2">
            <div>
              <p class="text-xs font-semibold uppercase tracking-widest text-gray-500">
                Our Best Sellers
              </p>
              <h2 class="mt-4 text-3xl font-bold text-gray-900 sm:text-4xl">
                -20% Off for<br />Bestsellers Product
              </h2>
              <p class="mt-4 text-gray-600">
                Update your wardrobe with our most loved pieces. Simple cuts, premium fabrics, and timeless elegance.
              </p>

              <a
                href="/bestsellers"
                class="mt-8 inline-block rounded-full bg-gray-900 px-8 py-3 text-sm font-medium text-white transition hover:bg-gray-800"
              >
                Shop Now
              </a>
            </div>
            <div class="mt-8">
              <img src="/images/main.jpeg" alt="Bestsellers" class="rounded-lg" />
            </div>
          </div>
          
    <!-- Products Grid -->
          <div class="grid gap-6 sm:grid-cols-2 lg:col-span-2 lg:grid-cols-2">
            <%= for product <- @bestsellers do %>
              <div class="group">
                <div class="overflow-hidden rounded-lg bg-gray-100">
                  <img
                    src={product.main_image}
                    alt={product.name}
                    class="aspect-[3/4] w-full object-cover transition-transform group-hover:scale-105"
                  />
                </div>
                
    <!-- Color Swatches -->
                <div class="mt-4 flex gap-2">
                  <%= for color <- product.colors do %>
                    <button
                      class={"h-6 w-6 rounded-full border-2 #{if color.selected, do: "border-gray-900", else: "border-gray-200"}"}
                      style={"background-color: #{color.hex}"}
                    >
                    </button>
                  <% end %>
                </div>

                <h3 class="mt-3 text-sm font-medium text-gray-900">{product.name}</h3>
                <p class="mt-1 font-semibold text-gray-900">$ {product.price} USD</p>
                
    <!-- Rating -->
                <div class="mt-2 flex items-center gap-1">
                  <div class="flex text-yellow-400">
                    <%= for _i <- 1..Decimal.to_integer(Decimal.round(product.rating, 0, :floor)) do %>
                      <svg class="h-4 w-4 fill-current" viewBox="0 0 20 20">
                        <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z" />
                      </svg>
                    <% end %>
                  </div>
                  <span class="text-sm text-gray-500">({product.rating})</span>
                </div>
              </div>
            <% end %>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def countdown(assigns) do
    ~H"""
    <section class="px-4 py-8 sm:px-6 lg:px-8">
      <div class="mx-auto max-w-6xl overflow-hidden rounded-3xl bg-gray-900">
        <div class="grid lg:grid-cols-2">
          <!-- Countdown Side -->
          <div class="relative flex flex-col items-center justify-center px-8 py-12 lg:border-r lg:border-gray-700 lg:py-20">
            <!-- Background Pattern (dots) -->
            <div class="absolute inset-0 opacity-10">
              <!-- Add dot pattern via CSS or SVG -->
            </div>

            <p class="relative text-xs font-semibold uppercase tracking-widest text-gray-400">
              Up to 25% Off Sale
            </p>
            
    <!-- Timer -->
            <div class="relative mt-8 flex items-center gap-2 text-white sm:gap-4">
              <div class="text-center">
                <span class="text-4xl font-bold sm:text-5xl lg:text-6xl" id="days">9</span>
                <p class="mt-2 text-xs text-gray-400 sm:text-sm">Days</p>
              </div>
              <span class="text-3xl font-light text-gray-500 sm:text-4xl">:</span>
              <div class="text-center">
                <span class="text-4xl font-bold sm:text-5xl lg:text-6xl" id="hours">19</span>
                <p class="mt-2 text-xs text-gray-400 sm:text-sm">Hours</p>
              </div>
              <span class="text-3xl font-light text-gray-500 sm:text-4xl">:</span>
              <div class="text-center">
                <span class="text-4xl font-bold sm:text-5xl lg:text-6xl" id="minutes">22</span>
                <p class="mt-2 text-xs text-gray-400 sm:text-sm">Minutes</p>
              </div>
              <span class="text-3xl font-light text-gray-500 sm:text-4xl">:</span>
              <div class="text-center">
                <span class="text-4xl font-bold sm:text-5xl lg:text-6xl" id="seconds">37</span>
                <p class="mt-2 text-xs text-gray-400 sm:text-sm">Seconds</p>
              </div>
            </div>
          </div>
          
    <!-- CTA Side -->
          <div class="flex flex-col items-center justify-center px-8 py-12 text-center lg:items-start lg:py-20 lg:text-left">
            <h2 class="text-3xl font-bold text-white sm:text-4xl">
              Get Your Dress Look Today
            </h2>
            <p class="mt-4 text-gray-400">
              We checked out a bunch of stores and finally found the perfect dress!
            </p>
            <a
              href="/sale"
              class="mt-8 rounded-full bg-white px-8 py-3 text-sm font-medium text-gray-900 transition hover:bg-gray-100"
            >
              Shop The Sale
            </a>
          </div>
        </div>
      </div>
    </section>

    <script>
      // Countdown Timer Logic
      function updateCountdown() {
        const endDate = new Date();
        endDate.setDate(endDate.getDate() + 9);

        const now = new Date();
        const diff = endDate - now;

        const days = Math.floor(diff / (1000 * 60 * 60 * 24));
        const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((diff % (1000 * 60)) / 1000);

        document.getElementById('days').textContent = days;
        document.getElementById('hours').textContent = hours;
        document.getElementById('minutes').textContent = minutes;
        document.getElementById('seconds').textContent = seconds;
      }

      setInterval(updateCountdown, 1000);
    </script>
    """
  end

  def partners(assigns) do
    ~H"""
    <section class="bg-white px-4 py-16 sm:px-6 lg:px-8 lg:py-24">
      <div class="mx-auto max-w-7xl">
        <!-- Partners Header -->
        <div class="text-center">
          <h2 class="font-serif text-3xl font-bold text-gray-900 sm:text-4xl">Our Partners</h2>
          <p class="mx-auto mt-4 max-w-2xl text-gray-600">
            Discover your next style adventure with us. Our legendary, crafted jeans are designed to become the celebrated highlight of your entire wardrobe collection.
          </p>
        </div>
        
    <!-- Partner Logos with Navigation -->
        <div class="relative mt-12">
          <button class="absolute -left-4 top-1/2 z-10 hidden -translate-y-1/2 rounded-full border border-gray-200 bg-white p-3 shadow-sm transition hover:bg-gray-50 lg:block">
            <svg class="h-5 w-5 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M15 19l-7-7 7-7"
              />
            </svg>
          </button>

          <div class="flex flex-wrap items-center justify-center gap-8 lg:gap-16">
            <span class="font-['Pacifico'] text-2xl text-gray-900">Smile</span>
            <span class="font-['Sacramento'] text-3xl text-gray-400">Anna's</span>
            <span class="font-['Great_Vibes'] text-3xl text-gray-300">Saturday</span>
            <span class="text-2xl font-light tracking-widest text-gray-400">rosé</span>
            <span class="font-['Yellowtail'] text-2xl text-gray-300">Mockup</span>
          </div>

          <button class="absolute -right-4 top-1/2 z-10 hidden -translate-y-1/2 rounded-full border border-gray-200 bg-white p-3 shadow-sm transition hover:bg-gray-50 lg:block">
            <svg class="h-5 w-5 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
            </svg>
          </button>
        </div>
        
    <!-- Instagram Gallery -->
        <div class="mt-16 grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4">
          <%= for {image, index} <- Enum.with_index(@instagram_images) do %>
            <div class="group relative overflow-hidden rounded-xl">
              <img
                src={image.url}
                alt={"Instagram post #{index + 1}"}
                class="aspect-square w-full object-cover transition-transform duration-300 group-hover:scale-110"
              />
              <%= if image.featured do %>
                <div class="absolute inset-0 flex flex-col items-center justify-center bg-gray-900/70 text-white">
                  <span class="text-2xl font-bold">@dojeen</span>
                  <span class="mt-2 text-sm">Fashion Product On Our Online Store.</span>
                </div>
              <% end %>
            </div>
          <% end %>
        </div>
      </div>
    </section>
    """
  end
end
