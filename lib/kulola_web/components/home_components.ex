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
    <section class="relative bg-white" id="hero-section" phx-hook="HeroReveal">
      <div class="grid min-h-[600px] lg:min-h-[700px] lg:grid-cols-2">
        <!-- Left Content -->
        <div class="relative flex flex-col justify-center overflow-hidden bg-[#f5f5f3] px-6 py-12 sm:px-12 lg:px-16 xl:px-24">
          <!-- Black Overlay (Left) -->
          <div
            id="hero-overlay-left"
            class="pointer-events-none absolute inset-0 z-20 bg-black transition-transform duration-700 ease-out"
            style="transform: translateX(0%);"
          >
          </div>
          
    <!-- Background Marquee Text -->
          <div class="pointer-events-none absolute inset-0 flex items-center overflow-hidden opacity-[0.04]">
            <div class="animate-marquee-slow flex whitespace-nowrap">
              <span class="mx-4 text-[120x] font-bold uppercase leading-none tracking-tight sm:text-[280px] lg:text-[350px]">
                Kulola's Closet
              </span>
              <span class="mx-4 text-[120x] font-bold uppercase leading-none tracking-tight sm:text-[280px] lg:text-[350px]">
                Kulola's Closet
              </span>
              <span class="mx-4 text-[120x] font-bold uppercase leading-none tracking-tight sm:text-[280px] lg:text-[350px]">
                Kulola's Closet
              </span>
            </div>
          </div>
          
    <!-- Content -->
          <div class="hero-content relative z-10 opacity-0 transition-all delay-300 duration-700">
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
        </div>
        
    <!-- Right Image -->
        <div class="relative min-h-[400px] overflow-hidden lg:min-h-full">
          <!-- Black Overlay (Right) -->
          <div
            id="hero-overlay-right"
            class="pointer-events-none absolute inset-0 z-20 bg-black transition-transform duration-700 ease-out"
            style="transform: translateX(0%);"
          >
          </div>

          <img
            id="hero-image"
            src="/images/main.jpeg"
            alt="Spring collection model"
            class="absolute inset-0 h-full w-full object-cover opacity-0 transition-all duration-700"
            style="transform: scale(1.1);"
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
        <div class="text-center" data-motion-reveal>
          <p class="text-xs font-semibold uppercase tracking-widest text-gray-500">
            Fashion's Gallery
          </p>
          <h2 class="mt-3 font-serif text-3xl font-bold italic text-gray-900 sm:text-4xl lg:text-5xl">
            Explore Our Collections
          </h2>
        </div>
        <div class="mt-12 grid gap-4 sm:grid-cols-2 lg:grid-cols-5" data-motion-stagger-group="0.06">
          <%= for {collection, index} <- Enum.with_index(@collections, 1) do %>
            <a
              href={collection.href}
              class="group relative flex min-h-[220px] flex-col justify-between rounded-xl border border-gray-200 bg-white p-5 transition-all hover:border-transparent hover:bg-[#e8dfd4] hover:shadow-lg"
              data-motion-reveal
            >
              <div>
                <span class="text-sm text-gray-400">{String.pad_leading("#{index}", 2, "0")}</span>
                <h3 class="mt-2 text-xl font-semibold text-gray-900">{collection.name}</h3>
              </div>

              <%= if collection.image do %>
                <div class="my-4 opacity-0 transition-opacity  ease-in-out duration-500 group-hover:opacity-100">
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
        <div class="text-center" data-motion-reveal>
          <p class="text-xs font-semibold uppercase tracking-widest text-gray-500">New Arrivals</p>
          <h2 class="mt-3 font-serif text-3xl font-bold text-gray-900 sm:text-4xl lg:text-5xl">
            Modern & Trendy Styles<br />Just Arrived
          </h2>
        </div>
        
    <!-- Products Carousel (Swiper) with external navigation -->
        <div class="relative mt-12">
          <!-- Nav Arrows - positioned outside the swiper container -->
          <button
            type="button"
            id="new-arrivals-prev"
            class="new-arrivals-nav-btn absolute -left-6 top-[200px] z-20 hidden h-12 w-12 items-center justify-center rounded-full border border-gray-200 bg-white text-gray-600 shadow-sm transition hover:border-gray-900 hover:text-gray-900 lg:flex xl:-left-16"
            aria-label="Previous"
          >
            <svg
              class="h-5 w-5"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              viewBox="0 0 24 24"
            >
              <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7" />
            </svg>
          </button>

          <button
            type="button"
            id="new-arrivals-next"
            class="new-arrivals-nav-btn absolute -right-6 top-[200px] z-20 hidden h-12 w-12 items-center justify-center rounded-full border border-gray-200 bg-white text-gray-600 shadow-sm transition hover:border-gray-900 hover:text-gray-900 lg:flex xl:-right-16"
            aria-label="Next"
          >
            <svg
              class="h-5 w-5"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              viewBox="0 0 24 24"
            >
              <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7" />
            </svg>
          </button>

          <div
            class="swiper new-arrivals-swiper overflow-hidden"
            id="swipernewarrival"
            phx-hook="SwiperNewArrivals"
          >
            <div class="swiper-wrapper">
              <%= for product <- @products do %>
                <div class="swiper-slide">
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
                </div>
              <% end %>
            </div>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def banner(assigns) do
    assigns = assign_new(assigns, :items, fn -> DummyData.marquee_items() end)

    ~H"""
    <section class="overflow-hidden border-y border-gray-100 bg-white py-4">
      <div class="group flex">
        <div class="flex animate-scroll-left">
          <%= for _copy <- 1..4 do %>
            <div class="flex shrink-0">
              <%= for item <- @items do %>
                <div class="flex shrink-0 items-center gap-3 px-8">
                  <span class="text-2xl">{item.icon}</span>
                  <span class="whitespace-nowrap text-sm font-medium text-gray-700">{item.text}</span>
                </div>
              <% end %>
            </div>
          <% end %>
        </div>
      </div>
    </section>

    <style>
      @keyframes scroll-left {
        0% {
          transform: translateX(0);
        }
        100% {
          transform: translateX(-50%);
        }
      }

      .animate-scroll-left {
        animation: scroll-left 30s linear infinite;
      }

      .group:hover .animate-scroll-left {
        animation-play-state: paused;
      }
    </style>
    """
  end

  def two_column_collection(assigns) do
    ~H"""
    <section class="bg-white px-4 py-16 sm:px-6 lg:px-8">
      <div class="mx-auto grid max-w-7xl gap-6 lg:grid-cols-2" data-motion-stagger-group="0.12">
        <%= for _collection <- [1,2] do %>
          <div class="group flex flex-col overflow-hidden bg-gray-100 sm:flex-row" data-motion-reveal>
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
            <div class="relative h-[300px] cursor-pointer flex-1 sm:min-h-0">
              <img
                src="/images/main.jpeg"
                alt="Elegant dress"
                class="absolute inset-0 hover:scale-110 transition-all ease-in-out duration-500 h-full w-full object-cover"
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
    <section
      class="relative mx-4 my-8 sm:mx-6 lg:mx-8"
      id="video-banner-section"
      phx-hook="VideoBannerReveal"
    >
      <!-- Circular reveal container -->
      <div class="relative min-h-[500px] overflow-hidden rounded-3xl bg-black sm:min-h-[600px] lg:min-h-[700px]">
        <!-- Video Background with clip-path animation -->
        <div
          id="video-reveal-container"
          class="absolute inset-0 transition-[clip-path] duration-1000 ease-out"
          style="clip-path: circle(0% at 50% 50%);"
        >
          <video
            id="hero-video"
            class="absolute inset-0 h-full w-full object-[40%] object-cover"
            muted
            autoplay
            loop
            playsinline
          >
            <source src="/images/video.mp4" type="video/mp4" />
          </video>
          <!-- Overlay -->
          <div class="absolute inset-0 bg-black/30"></div>
        </div>
        
    <!-- Content (always visible) -->
        <div class="relative z-10 flex h-full min-h-[500px] flex-col items-center justify-center px-6 text-center sm:min-h-[600px] lg:min-h-[700px]">
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
            type="button"
            class="mt-10 flex h-16 w-16 items-center justify-center rounded-full bg-white text-gray-900 shadow-lg transition hover:scale-105 sm:h-20 sm:w-20"
            aria-label="Play or pause video"
          >
            <svg
              id="pause-icon"
              class="hidden h-6 w-6 sm:h-8 sm:w-8"
              fill="currentColor"
              viewBox="0 0 24 24"
            >
              <path d="M6 4h4v16H6V4zm8 0h4v16h-4V4z" />
            </svg>
            <svg id="play-icon" class="h-6 w-6 sm:h-8 sm:w-8" fill="currentColor" viewBox="0 0 24 24">
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
        <div class="text-center" data-motion-reveal>
          <p class="text-xs font-semibold uppercase tracking-widest text-gray-500">Bundle & Save</p>
          <h2 class="mt-3 font-serif text-3xl font-bold text-gray-900 sm:text-4xl lg:text-5xl">
            Build Your Product Bundle<br />& Save Money
          </h2>
        </div>
        
    <!-- Content Grid -->
        <div class="mt-12 overflow-hidden rounded-2xl border border-gray-200">
          <div class="grid lg:grid-cols-5">
            <!-- Products Grid (Scrollable) - Takes 3 columns -->
            <div class="lg:col-span-3 lg:h-[700px] lg:overflow-y-auto">
              <div class="grid grid-cols-2 gap-px bg-gray-200">
                <%= for product <- @bundle_products do %>
                  <a href={product.href} class="group bg-white p-5 transition hover:bg-gray-50">
                    <div class="overflow-hidden rounded-lg bg-gray-100">
                      <img
                        src={product.main_image}
                        alt={product.name}
                        class="aspect-square w-full object-contain p-4 transition-transform duration-300 group-hover:scale-105"
                      />
                    </div>
                    <div class="mt-4 border-t border-gray-200 pt-4">
                      <!-- Color Swatches -->
                      <div class="flex gap-2">
                        <%= for color <- product.colors do %>
                          <span
                            class={"h-7 w-7 rounded-full border-2 #{if color.selected, do: "border-gray-900", else: "border-gray-200"}"}
                            style={"background-color: #{color.hex}"}
                          >
                          </span>
                        <% end %>
                      </div>
                      <h3 class="mt-3 text-sm font-medium text-gray-900">{product.name}</h3>
                      <p class="mt-1 font-semibold text-gray-900">$ {product.price} USD</p>
                    </div>
                  </a>
                <% end %>
              </div>
              
    <!-- Shop Now Button -->
              <div class="border-t border-gray-200 bg-white p-6 text-center">
                <a
                  href="/shop/bundles"
                  class="inline-block rounded-full bg-gray-900 px-10 py-3 text-sm font-medium text-white transition hover:bg-gray-800"
                >
                  Shop Now
                </a>
              </div>
            </div>
            
    <!-- Featured Image (Fixed) - Takes 2 columns -->
            <div class="hidden lg:col-span-2 lg:block">
              <img
                src="/images/main.jpeg"
                alt="Bundle collection"
                class="h-full w-full object-cover lg:h-[700px]"
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
    <section
      class="relative bg-gray-50"
      id="testimonials-section"
      phx-hook="TestimonialsHorizontalScroll"
      data-motion-reveal
    >
      <!-- Sticky container -->
      <div class="sticky top-0 h-screen overflow-hidden">
        <!-- Header -->
        <div class="px-4 py-8  text-center sm:px-6 lg:px-8">
          <p class="text-xs font-semibold uppercase tracking-widest text-gray-500">Testimonial</p>
          <h2 class="mt-3 font-serif text-3xl font-bold text-gray-900 sm:text-4xl lg:text-5xl">
            Customer Feedback
          </h2>
        </div>
        
    <!-- Testimonials horizontal track -->
        <div class="relative h-[300px] overflow-visible">
          <div
            id="testimonials-track"
            class="absolute left-0 top-1/2 flex -translate-y-1/2 items-center gap-6 lg:gap-10"
            style="padding-left: calc(50vw - 300px);"
          >
            <%= for {testimonial, index} <- Enum.with_index(@testimonials) do %>
              <% rating_float = Decimal.to_float(testimonial.rating) %>
              <% full_stars = trunc(rating_float) %>
              <% has_half = rating_float - full_stars >= 0.5 %>

              <div
                class="testimonial-slide w-[500px] flex-shrink-0 transition-all duration-500 ease-out sm:w-[600px]"
                data-index={index}
              >
                <div class="testimonial-card rounded-2xl bg-white p-6 shadow-sm transition-all duration-500 ease-out sm:p-8">
                  <!-- Top section: Rating + Customer Image -->
                  <div class="flex items-start justify-between gap-4">
                    <div class="flex-1">
                      <!-- Rating -->
                      <div class="flex items-center gap-2">
                        <div class="flex text-yellow-400">
                          <%= for _i <- 1..full_stars do %>
                            <svg class="h-5 w-5 fill-current" viewBox="0 0 20 20">
                              <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z" />
                            </svg>
                          <% end %>
                          <%= if has_half do %>
                            <svg class="h-5 w-5" viewBox="0 0 20 20">
                              <defs>
                                <linearGradient id={"half-star-#{testimonial.id}"}>
                                  <stop offset="50%" stop-color="#FACC15" />
                                  <stop offset="50%" stop-color="#E5E7EB" />
                                </linearGradient>
                              </defs>
                              <path
                                fill={"url(#half-star-#{testimonial.id})"}
                                d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"
                              />
                            </svg>
                          <% end %>
                        </div>
                        <span class="text-sm text-gray-500">({testimonial.rating})</span>
                      </div>

                      <div class="mt-3 flex items-center gap-2">
                        <h4 class="font-semibold text-gray-900">{testimonial.name}</h4>
                        <span class="text-gray-400">—</span>
                        <span class="text-sm text-gray-500">{testimonial.role}</span>
                      </div>
                    </div>
                    
    <!-- Customer Image -->
                    <img
                      src={testimonial.avatar}
                      alt={testimonial.name}
                      class="h-28 w-24 flex-shrink-0 rounded-lg object-cover sm:h-36 sm:w-28"
                    />
                  </div>
                  
    <!-- Content -->
                  <p class="mt-4 leading-relaxed text-gray-600">{testimonial.content}</p>
                  
    <!-- Product Referenced -->
                  <div class="mt-6 flex items-center gap-3 rounded-lg bg-gray-50 p-3">
                    <img
                      src={testimonial.product.image}
                      alt={testimonial.product.name}
                      class="h-14 w-12 flex-shrink-0 rounded object-cover"
                    />
                    <div>
                      <p class="text-sm font-medium text-gray-900">{testimonial.product.name}</p>
                      <p class="text-sm text-gray-600">$ {testimonial.product.price} USD</p>
                    </div>
                  </div>
                </div>
              </div>
            <% end %>
          </div>
        </div>
      </div>
      
    <!-- Spacer for scroll distance -->
      <div class="pointer-events-none" style={"height: #{length(assigns.testimonials) * 30}vh;"}>
      </div>
    </section>
    """
  end

  def best_sellers(assigns) do
    ~H"""
    <section class="bg-white px-4 py-16 sm:px-6 lg:px-8 lg:py-24" data-motion-reveal>
      <div class="mx-auto max-w-7xl">
        <div class="grid gap-6 lg:grid-cols-12">
          <!-- Left Promo Card - Takes 4 columns, spans full height -->
          <div class="flex flex-col rounded-2xl bg-gray-100 p-6 sm:p-8 lg:col-span-8 lg:row-span-2">
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
            <div class="mt-auto pt-8">
              <video
                src="/images/video.mp4"
                alt="Bestsellers"
                class="aspect-[4/3] w-full rounded-lg object-top object-cover"
                autoplay
                loop
                playsinline
                muted
              />
            </div>
          </div>

          <div class="grid grid-cols-2 gap-6 lg:col-span-4">
            <%= for product <- @bestsellers do %>
              <div class="group">
                <div class="overflow-hidden rounded-lg bg-gray-100">
                  <img
                    src={product.main_image}
                    alt={product.name}
                    class="aspect-[3/4] h-[300px] w-full object-cover object-top transition-transform duration-300 group-hover:scale-105"
                  />
                </div>

                <div class="mt-4 flex gap-2">
                  <%= for color <- product.colors do %>
                    <button
                      class={"h-7 w-7 rounded-full border-2 transition-all hover:scale-110 #{if color.selected, do: "border-gray-900", else: "border-gray-200 hover:border-gray-400"}"}
                      style={"background-color: #{color.hex}"}
                      aria-label={"Select #{color.name}"}
                    >
                    </button>
                  <% end %>
                </div>

                <h3 class="mt-3 text-sm font-medium text-gray-900">{product.name}</h3>
                <p class="mt-1 font-semibold text-gray-900">$ {product.price} USD</p>

                <div class="mt-2 flex items-center gap-1">
                  <div class="flex text-yellow-400">
                    <% rating_float = Decimal.to_float(product.rating) %>
                    <% full_stars = trunc(rating_float) %>
                    <% has_half = rating_float - full_stars >= 0.5 %>

                    <%= for _i <- 1..full_stars do %>
                      <svg class="h-4 w-4 fill-current" viewBox="0 0 20 20">
                        <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z" />
                      </svg>
                    <% end %>
                    <%= if has_half do %>
                      <svg class="h-4 w-4" viewBox="0 0 20 20">
                        <defs>
                          <linearGradient id={"half-rating-#{product.id}"}>
                            <stop offset="50%" stop-color="#FACC15" />
                            <stop offset="50%" stop-color="#E5E7EB" />
                          </linearGradient>
                        </defs>
                        <path
                          fill={"url(#half-rating-#{product.id})"}
                          d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"
                        />
                      </svg>
                    <% end %>
                    <%= for _i <- 1..(5 - full_stars - if(has_half, do: 1, else: 0)) do %>
                      <svg class="h-4 w-4 fill-gray-200" viewBox="0 0 20 20">
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
    <section class="px-4 py-8 sm:px-6 lg:px-8" id="countdown-section" phx-hook="CountdownTimer">
      <div class="mx-auto max-w-7xl overflow-hidden rounded-3xl bg-gray-950 relative">
        <!-- Dot Pattern Background -->
        <div class="absolute inset-0 overflow-hidden">
          <svg
            class="absolute bottom-0 left-0 w-full h-1/2 opacity-20"
            xmlns="http://www.w3.org/2000/svg"
          >
            <defs>
              <pattern
                id="dot-pattern"
                x="0"
                y="0"
                width="20"
                height="20"
                patternUnits="userSpaceOnUse"
              >
                <circle cx="2" cy="2" r="1.5" fill="white" />
              </pattern>
              <mask id="fade-mask">
                <linearGradient id="fade-gradient" x1="0%" y1="0%" x2="0%" y2="100%">
                  <stop offset="0%" stop-color="black" />
                  <stop offset="40%" stop-color="white" />
                  <stop offset="100%" stop-color="white" />
                </linearGradient>
                <rect width="100%" height="100%" fill="url(#fade-gradient)" />
              </mask>
            </defs>
            <rect width="100%" height="100%" fill="url(#dot-pattern)" mask="url(#fade-mask)" />
          </svg>
        </div>

        <div class="relative z-10 grid lg:grid-cols-2">
          <!-- Countdown Side -->
          <div class="relative flex flex-col items-center justify-center px-6 py-16 sm:px-12 lg:border-r lg:border-gray-800 lg:py-24">
            <p class="text-xs font-semibold uppercase tracking-[0.25em] text-gray-400">
              Up to 25% Off Sale
            </p>
            
    <!-- Timer -->
            <div class="mt-10 flex items-baseline gap-3 sm:gap-5">
              <div class="text-center">
                <span
                  class="font-display text-5xl font-bold tabular-nums text-white sm:text-6xl lg:text-7xl"
                  id="countdown-days"
                >
                  9
                </span>
                <p class="mt-3 text-sm font-medium text-gray-500">Days</p>
              </div>

              <span class="text-4xl font-light text-gray-600 sm:text-5xl lg:text-6xl">:</span>

              <div class="text-center">
                <span
                  class="font-display text-5xl font-bold tabular-nums text-white sm:text-6xl lg:text-7xl"
                  id="countdown-hours"
                >
                  19
                </span>
                <p class="mt-3 text-sm font-medium text-gray-500">Hours</p>
              </div>

              <span class="text-4xl font-light text-gray-600 sm:text-5xl lg:text-6xl">:</span>

              <div class="text-center">
                <span
                  class="font-display text-5xl font-bold tabular-nums text-white sm:text-6xl lg:text-7xl"
                  id="countdown-minutes"
                >
                  23
                </span>
                <p class="mt-3 text-sm font-medium text-gray-500">Minutes</p>
              </div>

              <span class="text-4xl font-light text-gray-600 sm:text-5xl lg:text-6xl">:</span>

              <div class="text-center">
                <span
                  class="font-display text-5xl font-bold tabular-nums text-white sm:text-6xl lg:text-7xl"
                  id="countdown-seconds"
                >
                  59
                </span>
                <p class="mt-3 text-sm font-medium text-gray-500">Seconds</p>
              </div>
            </div>
          </div>
          
    <!-- CTA Side -->
          <div class="flex flex-col items-center justify-center px-6 py-16 text-center sm:px-12 lg:items-start lg:py-24 lg:text-left">
            <h2 class="text-3xl font-bold leading-tight text-white sm:text-4xl lg:text-5xl">
              Get Your Dress Look Today
            </h2>
            <p class="mt-5 max-w-md text-base text-gray-400 lg:text-lg">
              We checked out a bunch of stores and finally found the perfect dress!
            </p>
            <a
              href="/sale"
              class="mt-8 inline-flex items-center justify-center rounded-full bg-white px-10 py-4 text-sm font-semibold text-gray-900 transition-all hover:bg-gray-100 hover:shadow-lg"
            >
              Shop The Sale
            </a>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def features(assigns) do
    ~H"""
    <section class="bg-white px-4 py-16 sm:px-6 lg:px-8 lg:py-20">
      <div class="mx-auto max-w-7xl">
        <div class="grid gap-8 sm:grid-cols-2 lg:grid-cols-4" data-motion-stagger-group="0.08">
          <div class="flex flex-col items-center text-center" data-motion-reveal>
            <div class="flex h-16 w-16 items-center justify-center">
              <svg
                class="h-12 w-12 text-gray-900"
                viewBox="0 0 48 48"
                fill="none"
                stroke="currentColor"
                stroke-width="1.5"
              >
                <circle cx="24" cy="24" r="18" />
                <ellipse cx="24" cy="24" rx="8" ry="18" />
                <path d="M6 24h36" />
                <path d="M24 6c6 4 10 10 10 18s-4 14-10 18" />
                <path d="M24 6c-6 4-10 10-10 18s4 14 10 18" />
                <circle cx="38" cy="34" r="6" fill="white" stroke="currentColor" />
                <path d="M36 34h4M38 32v4" stroke-linecap="round" />
              </svg>
            </div>
            <h3 class="mt-4 text-lg font-semibold text-gray-900">Worldwide Shipping</h3>
            <p class="mt-2 text-sm text-gray-500">Free shipping on all orders</p>
          </div>
          
          <div class="flex flex-col items-center text-center" data-motion-reveal>
            <div class="flex h-16 w-16 items-center justify-center">
              <svg
                class="h-12 w-12 text-gray-900"
                viewBox="0 0 48 48"
                fill="none"
                stroke="currentColor"
                stroke-width="1.5"
              >
                <rect x="6" y="14" width="36" height="24" rx="4" />
                <path d="M6 22h36" />
                <rect x="10" y="30" width="8" height="4" rx="1" />
              </svg>
            </div>
            <h3 class="mt-4 text-lg font-semibold text-gray-900">Secured Payment</h3>
            <p class="mt-2 text-sm text-gray-500">Safe & secured payments</p>
          </div>
          <div class="flex flex-col items-center text-center" data-motion-reveal>
            <div class="flex h-16 w-16 items-center justify-center">
              <svg
                class="h-12 w-12 text-gray-900"
                viewBox="0 0 48 48"
                fill="none"
                stroke="currentColor"
                stroke-width="1.5"
              >
                <rect x="8" y="8" width="20" height="26" rx="2" />
                <path d="M12 14h12M12 20h8" />
                <circle cx="34" cy="32" r="10" />
                <path d="M34 26v6l4 2" stroke-linecap="round" stroke-linejoin="round" />
              </svg>
            </div>
            <h3 class="mt-4 text-lg font-semibold text-gray-900">30-Days Free Returns</h3>
            <p class="mt-2 text-sm text-gray-500">Within 30 days for an exchange</p>
          </div>
          <div class="flex flex-col items-center text-center" data-motion-reveal>
            <div class="flex h-16 w-16 items-center justify-center">
              <svg
                class="h-12 w-12 text-gray-900"
                viewBox="0 0 48 48"
                fill="none"
                stroke="currentColor"
                stroke-width="1.5"
              >
                <rect x="8" y="20" width="32" height="22" rx="2" />
                <rect x="6" y="14" width="36" height="8" rx="2" />
                <path d="M24 14v28" />
                <path d="M24 14c-4-6-12-6-12 0s8 6 12 0" />
                <path d="M24 14c4-6 12-6 12 0s-8 6-12 0" />
              </svg>
            </div>
            <h3 class="mt-4 text-lg font-semibold text-gray-900">Surprise Gift</h3>
            <p class="mt-2 text-sm text-gray-500">Free gift cards & vouchers</p>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def footer(assigns) do
    ~H"""
    <footer class="bg-black">
      <!-- Main Footer Content -->
      <div class="mx-auto max-w-7xl px-4 py-12 sm:px-6 lg:px-8 lg:py-16">
        <div class="grid gap-8 sm:grid-cols-2 lg:grid-cols-4">
          <!-- Get In Touch -->
          <div>
            <h3 class="text-xl font-semibold text-white">Get In Touch</h3>
            <ul class="mt-6 space-y-4">
              <li class="flex items-center gap-3 text-gray-400">
                <svg
                  class="h-5 w-5 flex-shrink-0"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                  stroke-width="1.5"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M2.25 6.75c0 8.284 6.716 15 15 15h2.25a2.25 2.25 0 002.25-2.25v-1.372c0-.516-.351-.966-.852-1.091l-4.423-1.106c-.44-.11-.902.055-1.173.417l-.97 1.293c-.282.376-.769.542-1.21.38a12.035 12.035 0 01-7.143-7.143c-.162-.441.004-.928.38-1.21l1.293-.97c.363-.271.527-.734.417-1.173L6.963 3.102a1.125 1.125 0 00-1.091-.852H4.5A2.25 2.25 0 002.25 4.5v2.25z"
                  />
                </svg>
                <span>(+00) 123 456 789</span>
              </li>
              <li class="flex items-center gap-3 text-gray-400">
                <svg
                  class="h-5 w-5 flex-shrink-0"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                  stroke-width="1.5"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M21.75 6.75v10.5a2.25 2.25 0 01-2.25 2.25h-15a2.25 2.25 0 01-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25m19.5 0v.243a2.25 2.25 0 01-1.07 1.916l-7.5 4.615a2.25 2.25 0 01-2.36 0L3.32 8.91a2.25 2.25 0 01-1.07-1.916V6.75"
                  />
                </svg>
                <span>support@example.com</span>
              </li>
              <li class="flex items-center gap-3 text-gray-400">
                <svg
                  class="h-5 w-5 flex-shrink-0"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                  stroke-width="1.5"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25"
                  />
                </svg>
                <span>Elgin St. Celina, Delaware 10299</span>
              </li>
            </ul>
            
    <!-- Social Icons -->
            <div class="mt-8 flex gap-3">
              <a
                href="#"
                class="flex h-10 w-10 items-center justify-center rounded-full border border-gray-700 text-gray-400 transition hover:border-white hover:text-white"
              >
                <svg class="h-4 w-4" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z" />
                </svg>
              </a>
              <a
                href="#"
                class="flex h-10 w-10 items-center justify-center rounded-full border border-gray-700 text-gray-400 transition hover:border-white hover:text-white"
              >
                <svg class="h-4 w-4" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z" />
                </svg>
              </a>
              <a
                href="#"
                class="flex h-10 w-10 items-center justify-center rounded-full border border-gray-700 text-gray-400 transition hover:border-white hover:text-white"
              >
                <svg class="h-4 w-4" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M12.525.02c1.31-.02 2.61-.01 3.91-.02.08 1.53.63 3.09 1.75 4.17 1.12 1.11 2.7 1.62 4.24 1.79v4.03c-1.44-.05-2.89-.35-4.2-.97-.57-.26-1.1-.59-1.62-.93-.01 2.92.01 5.84-.02 8.75-.08 1.4-.54 2.79-1.35 3.94-1.31 1.92-3.58 3.17-5.91 3.21-1.43.08-2.86-.31-4.08-1.03-2.02-1.19-3.44-3.37-3.65-5.71-.02-.5-.03-1-.01-1.49.18-1.9 1.12-3.72 2.58-4.96 1.66-1.44 3.98-2.13 6.15-1.72.02 1.48-.04 2.96-.04 4.44-.99-.32-2.15-.23-3.02.37-.63.41-1.11 1.04-1.36 1.75-.21.51-.15 1.07-.14 1.61.24 1.64 1.82 3.02 3.5 2.87 1.12-.01 2.19-.66 2.77-1.61.19-.33.4-.67.41-1.06.1-1.79.06-3.57.07-5.36.01-4.03-.01-8.05.02-12.07z" />
                </svg>
              </a>
              <a
                href="#"
                class="flex h-10 w-10 items-center justify-center rounded-full border border-gray-700 text-gray-400 transition hover:border-white hover:text-white"
              >
                <svg class="h-4 w-4" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z" />
                </svg>
              </a>
            </div>
          </div>
          
    <!-- Quick Links -->
          <div>
            <h3 class="text-xl font-semibold text-white">Quick Links</h3>
            <ul class="mt-6 space-y-3">
              <li>
                <a href="/" class="text-gray-400 transition hover:text-white">Home</a>
              </li>
              <li>
                <a href="/about" class="text-gray-400 transition hover:text-white">About</a>
              </li>
              <li>
                <a href="/shop" class="text-gray-400 transition hover:text-white">Shop</a>
              </li>
              <li>
                <a href="/blog" class="text-gray-400 transition hover:text-white">Blog</a>
              </li>
              <li>
                <a href="/contact" class="text-gray-400 transition hover:text-white">Contact</a>
              </li>
            </ul>
          </div>
          
    <!-- Utility Pages -->
          <div>
            <h3 class="text-xl font-semibold text-white">Utility Pages</h3>
            <ul class="mt-6 space-y-3">
              <li>
                <a href="/password-protected" class="text-gray-400 transition hover:text-white">
                  Password Protected
                </a>
              </li>
              <li>
                <a href="/404" class="text-gray-400 transition hover:text-white">404 Not Found</a>
              </li>
              <li>
                <a href="/style-guide" class="text-gray-400 transition hover:text-white">
                  Style Guide
                </a>
              </li>
              <li>
                <a href="/licenses" class="text-gray-400 transition hover:text-white">Licenses</a>
              </li>
              <li>
                <a href="/changelog" class="text-gray-400 transition hover:text-white">Changelog</a>
              </li>
            </ul>
          </div>
          
    <!-- Newsletter -->
          <div>
            <h3 class="text-xl font-semibold text-white">Newsletter</h3>
            <p class="mt-6 text-gray-400">
              Sign up for our newsletter to receive special offers.
            </p>

            <form class="mt-6" phx-submit="subscribe_newsletter">
              <div class="relative">
                <input
                  type="email"
                  name="email"
                  placeholder="Enter Your Email"
                  required
                  class="w-full rounded-full border border-gray-700 bg-transparent py-3 pl-5 pr-14 text-white placeholder-gray-500 transition focus:border-white focus:outline-none focus:ring-0"
                />
                <button
                  type="submit"
                  class="absolute right-1.5 top-1/2 -translate-y-1/2 flex h-9 w-9 items-center justify-center rounded-full bg-white text-gray-900 transition hover:bg-gray-200"
                >
                  <svg
                    class="h-4 w-4"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    stroke-width="2"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      d="M4.5 19.5l15-15m0 0H8.25m11.25 0v11.25"
                    />
                  </svg>
                </button>
              </div>

              <label class="mt-4 flex items-start gap-3 text-sm text-gray-400">
                <input
                  type="checkbox"
                  name="terms"
                  class="mt-0.5 h-4 w-4 rounded border-gray-600 bg-transparent text-white focus:ring-0 focus:ring-offset-0"
                />
                <span>I agree with the terms & conditions</span>
              </label>
            </form>
          </div>
        </div>
      </div>
      
    <!-- Large Logo Marquee -->
      <div class="overflow-hidden border-t border-gray-400">
        <div class="animate-marquee-slow flex whitespace-nowrap py-8">
          <span class="mx-8 text-[100px] font-bold text-gray-100 sm:text-[140px] opacity-[0.8] lg:text-[180px]">
            Kulola's Closet
          </span>
          <span class="mx-8 text-[100px] font-bold text-gray-100 sm:text-[140px] opacity-[0.8] lg:text-[180px]">
            Kulola's Closet
          </span>
          <span class="mx-8 text-[100px] font-bold text-gray-100 sm:text-[140px] opacity-[0.8] lg:text-[180px]">
            Kulola's Closet
          </span>
          <span class="mx-8 text-[100px] font-bold text-gray-100 sm:text-[140px] opacity-[0.8] lg:text-[180px]">
            Kulola's Closet
          </span>
        </div>
      </div>
      
    <!-- Copyright -->
      <div class="border-t border-gray-400 py-6">
        <p class="text-center text-sm text-gray-500">
          Copyright © Dojeen. <span class="mx-2">|</span>
          Designed by <a href="#" class="text-white transition hover:underline">Brandbes</a>
          - Powered by <a href="#" class="text-white transition hover:underline">Webflow</a>
        </p>
      </div>
    </footer>
    """
  end
end
