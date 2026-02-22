alias Kulola.Repo
alias Kulola.Collections.Collection
alias Kulola.Products.Product
alias Kulola.ProductVariants.ProductVariant
alias Kulola.Testimonials.Testimonial

# Clear existing seed data so seeds can be re-run safely
Repo.delete_all(Kulola.Testimonials.Testimonial)
Repo.delete_all(Kulola.BundleItems.BundleItem)
Repo.delete_all(Kulola.Bundles.Bundle)
Repo.delete_all(Kulola.ProductVariants.ProductVariant)
Repo.delete_all(Kulola.ProductImages.ProductImage)
Repo.delete_all(Kulola.Products.Product)
Repo.delete_all(Kulola.Collections.Collection)
IO.puts("🗑️   Cleared existing data.")

# ─── Collections ────────────────────────────────────────────────────────────

collections =
  [
    %{
      title: "Co-ord Sets",
      slug: "coord-sets",
      image: "/images/products/red-denim-coord-set.jpg",
      position: 1,
      is_active: true
    },
    %{
      title: "Wide-Leg Pants",
      slug: "wide-leg-pants",
      image: "/images/products/black-wide-leg-pants-floral-top.jpg",
      position: 2,
      is_active: true
    },
    %{
      title: "Skirts",
      slug: "skirts",
      image: "/images/products/denim-maxi-skirt-front.jpg",
      position: 3,
      is_active: true
    },
    %{
      title: "Jumpsuits",
      slug: "jumpsuits",
      image: "/images/products/sage-linen-jumpsuit.jpg",
      position: 4,
      is_active: true
    },
    %{
      title: "Tops & Knits",
      slug: "tops-and-knits",
      image: "/images/products/grey-layered-knit-set-front.jpg",
      position: 5,
      is_active: true
    }
  ]

inserted_collections =
  Enum.map(collections, fn attrs ->
    {:ok, collection} =
      %Collection{}
      |> Collection.changeset(attrs)
      |> Repo.insert()

    collection
  end)

get_collection = fn slug ->
  Enum.find(inserted_collections, &(&1.slug == slug))
end

# ─── Products ────────────────────────────────────────────────────────────────

products = [
  # ── Co-ord Sets ──────────────────────────────────────────────────────────
  %{
    name: "Red & Denim Co-ord Set",
    slug: "red-denim-coord-set",
    description:
      "A bold statement co-ord set featuring a cropped red sweatshirt layered over a denim shirt, paired with matching red wide-leg trousers finished with raw-hem denim side-stripe detailing. Effortlessly cool with white sneakers.",
    base_price: 4_800,
    image: "/images/products/red-denim-coord-set.jpg",
    badge_label: "Bestseller",
    badge_color: "red",
    is_featured: true,
    is_bestseller: true,
    is_new_arrival: false,
    position: 1,
    status: "active",
    collection_slug: "coord-sets",
    colors: [{"Red", "#CC2936"}, {"Denim Blue", "#4A7FB5"}]
  },
  %{
    name: "Orange & Denim Co-ord Set",
    slug: "orange-denim-coord-set",
    description:
      "Vibrant burnt-orange co-ord set with a cropped pullover and wide-leg trousers, both accented with frayed denim contrast panels and cuffs. A denim shirt peeking underneath adds a layered finish.",
    base_price: 4_800,
    image: "/images/products/orange-denim-coord-set.jpg",
    badge_label: "New",
    badge_color: "green",
    is_featured: true,
    is_bestseller: false,
    is_new_arrival: true,
    position: 2,
    status: "active",
    collection_slug: "coord-sets",
    colors: [{"Orange", "#F97316"}, {"Denim Blue", "#4A7FB5"}]
  },
  %{
    name: "Chocolate Knit Co-ord Set",
    slug: "chocolate-knit-coord-set",
    description:
      "Luxuriously soft chocolate-brown knit co-ord set comprising an oversized drop-shoulder sweater with a cream contrast stripe hem and matching wide-leg knit trousers. The ultimate cosy-chic look.",
    base_price: 5_200,
    image: "/images/products/chocolate-knit-coord-set.jpg",
    badge_label: "New",
    badge_color: "green",
    is_featured: false,
    is_bestseller: false,
    is_new_arrival: true,
    position: 3,
    status: "active",
    collection_slug: "coord-sets",
    colors: [{"Chocolate", "#7B3F00"}, {"Cream", "#F5F0E8"}]
  },
  %{
    name: "Sage Linen Co-ord Set",
    slug: "sage-linen-coord-set",
    description:
      "Breezy sage-green linen co-ord set with a frilled-shoulder crop top and matching drawstring wide-leg trousers. Lightweight and effortlessly elegant for warm days.",
    base_price: 4_200,
    image: "/images/products/sage-linen-coord-set.jpg",
    badge_label: "Featured",
    badge_color: "blue",
    is_featured: true,
    is_bestseller: false,
    is_new_arrival: false,
    position: 4,
    status: "active",
    collection_slug: "coord-sets",
    colors: [{"Sage Green", "#8FAF7E"}, {"Olive", "#6B7C4A"}]
  },
  %{
    name: "Olive Linen Co-ord Set",
    slug: "olive-linen-coord-set",
    description:
      "Relaxed olive-green linen co-ord featuring a V-neck button-front tunic top with pearl buttons and matching wide-leg trousers. Pairs beautifully with heeled sandals for a polished casual look.",
    base_price: 4_500,
    image: "/images/products/olive-linen-coord-set.jpg",
    badge_label: nil,
    badge_color: nil,
    is_featured: false,
    is_bestseller: false,
    is_new_arrival: false,
    position: 5,
    status: "active",
    collection_slug: "coord-sets",
    colors: [{"Olive", "#6B7C4A"}, {"Cream", "#F5F0E8"}]
  },

  # ── Wide-Leg Pants ────────────────────────────────────────────────────────
  %{
    name: "Black Wide-Leg Palazzo Pants",
    slug: "black-wide-leg-palazzo-pants",
    description:
      "Sleek high-waisted black palazzo pants with a structured belt and deep pleats for a dramatic silhouette. The statement piece in any wardrobe — style with a crop top or tucked-in blouse.",
    base_price: 2_800,
    image: "/images/products/black-wide-leg-pants-floral-top.jpg",
    badge_label: "Bestseller",
    badge_color: "red",
    is_featured: true,
    is_bestseller: true,
    is_new_arrival: false,
    position: 6,
    status: "active",
    collection_slug: "wide-leg-pants",
    colors: [{"Black", "#1A1A1A"}, {"White", "#F5F5F5"}]
  },
  %{
    name: "Navy Wide-Leg Palazzo Pants",
    slug: "navy-wide-leg-palazzo-pants",
    description:
      "Fluid navy high-waisted palazzo pants with a matching belt and front pleats. Versatile enough for day or evening wear — shown here with a tie-dye bandeau and a pop-colour mini bag.",
    base_price: 2_800,
    image: "/images/products/navy-wide-leg-pants-bandeau.jpg",
    badge_label: nil,
    badge_color: nil,
    is_featured: false,
    is_bestseller: false,
    is_new_arrival: false,
    position: 7,
    status: "active",
    collection_slug: "wide-leg-pants",
    colors: [{"Navy", "#1B2A6B"}, {"Black", "#1A1A1A"}]
  },
  %{
    name: "Olive High-Waist Wide-Leg Trousers",
    slug: "olive-wide-leg-trousers",
    description:
      "Tailored olive-green wide-leg trousers with a high waist and front button detail. A clean silhouette that pairs perfectly with a white crop shirt for an elevated smart-casual look.",
    base_price: 2_600,
    image: "/images/products/olive-wide-leg-pants-white-crop.jpg",
    badge_label: nil,
    badge_color: nil,
    is_featured: false,
    is_bestseller: false,
    is_new_arrival: false,
    position: 8,
    status: "active",
    collection_slug: "wide-leg-pants",
    colors: [{"Olive", "#6B7C4A"}, {"Camel", "#C9A882"}]
  },
  %{
    name: "Light-Wash Wide-Leg Jeans",
    slug: "light-wash-wide-leg-jeans",
    description:
      "Relaxed-fit light-wash wide-leg jeans with a high rise and a clean, minimal finish. A wardrobe staple that grounds structured tops like a navy vest perfectly.",
    base_price: 3_200,
    image: "/images/products/navy-vest-wide-leg-jeans.jpg",
    badge_label: "New",
    badge_color: "green",
    is_featured: false,
    is_bestseller: false,
    is_new_arrival: true,
    position: 9,
    status: "active",
    collection_slug: "wide-leg-pants",
    colors: [{"Light Wash", "#B8D4E8"}, {"Dark Wash", "#2C4F7C"}]
  },
  %{
    name: "Navy Pinstripe Wide-Leg Trousers",
    slug: "navy-pinstripe-wide-leg-trousers",
    description:
      "Smart navy pinstripe wide-leg trousers from the matching blazer set. Power-dressing with an effortless twist — wear as a set or mix and match.",
    base_price: 3_000,
    image: "/images/products/navy-pinstripe-blazer-set.jpg",
    badge_label: "Featured",
    badge_color: "blue",
    is_featured: true,
    is_bestseller: false,
    is_new_arrival: false,
    position: 10,
    status: "active",
    collection_slug: "wide-leg-pants",
    colors: [{"Navy", "#1B2A6B"}]
  },

  # ── Skirts ────────────────────────────────────────────────────────────────
  %{
    name: "Denim Maxi Skirt",
    slug: "denim-maxi-skirt",
    description:
      "Voluminous mid-wash denim maxi skirt with a drawstring elasticated waist and sweeping panelled silhouette. Styled with a knotted graphic tee and a red crossbody for a relaxed street-style vibe.",
    base_price: 3_500,
    image: "/images/products/denim-maxi-skirt-front.jpg",
    badge_label: "Bestseller",
    badge_color: "red",
    is_featured: true,
    is_bestseller: true,
    is_new_arrival: false,
    position: 11,
    status: "active",
    collection_slug: "skirts",
    colors: [{"Mid-Wash Denim", "#7BA4C7"}, {"Dark Denim", "#2C4F7C"}]
  },
  %{
    name: "Burgundy Pleated Maxi Skirt",
    slug: "burgundy-pleated-maxi-skirt",
    description:
      "Dramatic floor-length burgundy pleated maxi skirt with a front split for ease of movement. Styled with a white logo shirt tucked behind a wide leather belt and paired with black knee boots and a structured satchel.",
    base_price: 3_800,
    image: "/images/products/burgundy-pleated-maxi-skirt.jpg",
    badge_label: "Featured",
    badge_color: "blue",
    is_featured: true,
    is_bestseller: false,
    is_new_arrival: false,
    position: 12,
    status: "active",
    collection_slug: "skirts",
    colors: [{"Burgundy", "#800020"}, {"Black", "#1A1A1A"}]
  },

  # ── Jumpsuits ─────────────────────────────────────────────────────────────
  %{
    name: "Sage Linen Jumpsuit",
    slug: "sage-linen-jumpsuit",
    description:
      "Effortless sage-green linen jumpsuit with frilled shoulders, an elasticated drawstring waist and wide-leg trousers. A one-piece wonder that looks polished with minimal accessories.",
    base_price: 4_000,
    image: "/images/products/sage-linen-jumpsuit.jpg",
    badge_label: "Featured",
    badge_color: "blue",
    is_featured: true,
    is_bestseller: false,
    is_new_arrival: false,
    position: 13,
    status: "active",
    collection_slug: "jumpsuits",
    colors: [{"Sage Green", "#8FAF7E"}, {"Blush", "#F5C4C4"}]
  },

  # ── Tops & Knits ──────────────────────────────────────────────────────────
  %{
    name: "Grey Layered Knit Top",
    slug: "grey-layered-knit-top",
    description:
      "Unique layered knit-over-shirt top in grey — a knitted sweater with button front detail sits over a woven shirt hem, creating a relaxed two-in-one look. Pairs effortlessly with shorts or jeans.",
    base_price: 2_500,
    image: "/images/products/grey-layered-knit-set-front.jpg",
    badge_label: nil,
    badge_color: nil,
    is_featured: false,
    is_bestseller: false,
    is_new_arrival: false,
    position: 14,
    status: "active",
    collection_slug: "tops-and-knits",
    colors: [{"Grey", "#9CA3AF"}, {"Black", "#1A1A1A"}]
  },
  %{
    name: "Black Layered Knit Top",
    slug: "black-layered-knit-top",
    description:
      "Edgy black version of the layered knit-over-shirt top with contrast button detailing. Styled with a quilted black crossbody bag for a sleek, put-together look.",
    base_price: 2_500,
    image: "/images/products/black-grey-layered-knit-set.jpg",
    badge_label: nil,
    badge_color: nil,
    is_featured: false,
    is_bestseller: false,
    is_new_arrival: false,
    position: 15,
    status: "active",
    collection_slug: "tops-and-knits",
    colors: [{"Black", "#1A1A1A"}, {"Charcoal", "#374151"}]
  },
  %{
    name: "Navy Structured Vest Top",
    slug: "navy-structured-vest-top",
    description:
      "Sharp navy structured vest top with mixed pearl and black button closures and a split hem. Tailored and modern — great over wide-leg jeans or as part of a smart-casual ensemble.",
    base_price: 2_200,
    image: "/images/products/navy-vest-wide-leg-jeans.jpg",
    badge_label: "New",
    badge_color: "green",
    is_featured: false,
    is_bestseller: false,
    is_new_arrival: true,
    position: 16,
    status: "active",
    collection_slug: "tops-and-knits",
    colors: [{"Navy", "#1B2A6B"}, {"Black", "#1A1A1A"}]
  },
  %{
    name: "Red Knit Cardigan",
    slug: "red-knit-cardigan",
    description:
      "Classic cropped red knit cardigan with jewelled buttons and a layered white collared shirt underneath. A timeless preppy-chic piece that transitions from casual to smart effortlessly.",
    base_price: 2_800,
    image: "/images/products/red-cardigan-black-wide-leg.jpg",
    badge_label: "Bestseller",
    badge_color: "red",
    is_featured: true,
    is_bestseller: true,
    is_new_arrival: false,
    position: 17,
    status: "active",
    collection_slug: "tops-and-knits",
    colors: [{"Red", "#CC2936"}, {"Black", "#1A1A1A"}]
  },
  %{
    name: "Navy Pinstripe Blazer",
    slug: "navy-pinstripe-blazer",
    description:
      "Cropped navy pinstripe co-ord blazer with short sleeves and a relaxed open-front silhouette. Wear as a set with the matching wide-leg trousers or layer over a crop top.",
    base_price: 3_500,
    image: "/images/products/navy-pinstripe-blazer-set.jpg",
    badge_label: "Featured",
    badge_color: "blue",
    is_featured: true,
    is_bestseller: false,
    is_new_arrival: false,
    position: 18,
    status: "active",
    collection_slug: "tops-and-knits",
    colors: [{"Navy", "#1B2A6B"}, {"Black", "#1A1A1A"}]
  },
  %{
    name: "White Puff-Sleeve Crop Shirt",
    slug: "white-puff-sleeve-crop-shirt",
    description:
      "Crisp white cropped shirt with voluminous puff sleeves and a gathered elastic hem. Pairs perfectly with high-waisted trousers for a polished yet playful look.",
    base_price: 2_000,
    image: "/images/products/olive-wide-leg-pants-white-crop.jpg",
    badge_label: nil,
    badge_color: nil,
    is_featured: false,
    is_bestseller: false,
    is_new_arrival: false,
    position: 19,
    status: "active",
    collection_slug: "tops-and-knits",
    colors: [{"White", "#F5F5F5"}, {"Blush", "#F5C4C4"}]
  },
  %{
    name: "Floral Bandeau Crop Top",
    slug: "floral-bandeau-crop-top",
    description:
      "Delicate black and white floral print bandeau crop top with a single shoulder strap. A versatile summer staple that looks stunning with wide-leg palazzo pants.",
    base_price: 1_500,
    image: "/images/products/black-wide-leg-pants-floral-top.jpg",
    badge_label: nil,
    badge_color: nil,
    is_featured: false,
    is_bestseller: false,
    is_new_arrival: false,
    position: 20,
    status: "active",
    collection_slug: "tops-and-knits",
    colors: [{"Black/White", "#1A1A1A"}, {"Beige", "#D4B896"}]
  }
]

sizes = ["XS", "S", "M", "L", "XL"]

inserted_products =
  Enum.map(products, fn attrs ->
    {collection_slug, attrs} = Map.pop(attrs, :collection_slug)
    {colors, attrs} = Map.pop(attrs, :colors)
    collection = get_collection.(collection_slug)
    attrs = Map.put(attrs, :collection_id, collection.id)

    {:ok, product} =
      %Product{}
      |> Product.changeset(attrs)
      |> Repo.insert()

    # Insert one variant per colour × size combination
    Enum.each(colors, fn {color_name, color_hex} ->
      Enum.each(sizes, fn size ->
        {:ok, _} =
          %ProductVariant{}
          |> ProductVariant.changeset(%{
            product_id: product.id,
            color_name: color_name,
            color_hex: color_hex,
            size: size,
            stock_quantity: "10"
          })
          |> Repo.insert()
      end)
    end)

    product
  end)

get_product = fn slug ->
  Enum.find(inserted_products, &(&1.slug == slug))
end

variant_count = length(inserted_products) * length(sizes) * 2

IO.puts(
  "✅  Seeded #{length(inserted_collections)} collections, #{length(inserted_products)} products, ~#{variant_count} variants."
)

# ─── Bundle ───────────────────────────────────────────────────────────────────

{:ok, bundle} =
  %Kulola.Bundles.Bundle{}
  |> Kulola.Bundles.Bundle.changeset(%{
    title: "The Kulola Starter Bundle",
    description:
      "Our curated starter bundle — everything you need to build a versatile, head-turning wardrobe. Includes our bestselling Black Wide-Leg Palazzo Pants, the Burgundy Pleated Maxi Skirt, the Red Knit Cardigan and the Denim Maxi Skirt. Mix, match and own every room.",
    image: "/images/products/black-wide-leg-pants-floral-top.jpg",
    is_active: true
  })
  |> Repo.insert()

bundle_item_slugs = [
  "black-wide-leg-palazzo-pants",
  "burgundy-pleated-maxi-skirt",
  "red-knit-cardigan",
  "denim-maxi-skirt"
]

Enum.each(bundle_item_slugs, fn slug ->
  product = get_product.(slug)

  {:ok, _} =
    %Kulola.BundleItems.BundleItem{}
    |> Kulola.BundleItems.BundleItem.changeset(%{
      bundle_id: bundle.id,
      product_id: product.id
    })
    |> Repo.insert()
end)

IO.puts("✅  Seeded 1 bundle with #{length(bundle_item_slugs)} items.")

# ─── Testimonials ─────────────────────────────────────────────────────────────

testimonials = [
  %{
    name: "Amina W.",
    position: 1,
    image: "/images/main.jpeg",
    body:
      "I ordered the Red & Denim Co-ord Set and I'm obsessed! The quality is incredible — the fabric feels premium and the fit is perfect. Got so many compliments on my first wear. Will definitely be ordering again!",
    rating: 5,
    is_active: true,
    product_slug: "red-denim-coord-set"
  },
  %{
    name: "Cynthia O.",
    position: 2,
    image: "/images/main.jpeg",
    body:
      "The Denim Maxi Skirt is everything I wanted. Beautifully structured, the waist fits perfectly and the length is just right. I styled it with a simple white tee and got so many compliments.",
    rating: 5,
    is_active: true,
    product_slug: "denim-maxi-skirt"
  },
  %{
    name: "Grace M.",
    position: 3,
    image: "/images/main.jpeg",
    body:
      "The Sage Linen Jumpsuit is my new favourite piece. Light, breathable and so flattering. I wore it to a garden party and everyone kept asking where I got it from. Kulola never disappoints!",
    rating: 5,
    is_active: true,
    product_slug: "sage-linen-jumpsuit"
  },
  %{
    name: "Fatuma K.",
    position: 4,
    image: "/images/main.jpeg",
    body:
      "Bought the Black Wide-Leg Palazzo Pants and they are absolutely stunning. The pleating is chef's kiss. Delivery was fast and the packaging was so elegant. This is my go-to shop now.",
    rating: 5,
    is_active: true,
    product_slug: "black-wide-leg-palazzo-pants"
  },
  %{
    name: "Sharon N.",
    position: 5,
    image: "/images/main.jpeg",
    body:
      "I've been looking for a quality Red Knit Cardigan for ages and this one is perfect. The buttons are beautiful and it layers so well. The sizing is true to size. Highly recommend!",
    rating: 4,
    is_active: true,
    product_slug: "red-knit-cardigan"
  },
  %{
    name: "Miriam A.",
    position: 6,
    image: "/images/main.jpeg",
    body:
      "The Burgundy Pleated Maxi Skirt is a showstopper. I wore it to a dinner event and felt like a queen. The fabric drapes beautifully and the colour is rich and deep. 10/10 purchase.",
    rating: 5,
    is_active: true,
    product_slug: "burgundy-pleated-maxi-skirt"
  },
  %{
    name: "Jackline T.",
    position: 7,
    image: "/images/main.jpeg",
    body:
      "The Chocolate Knit Co-ord Set is cosy luxury at its finest. Wore it on a cool evening out and it was the perfect weight — not too heavy, not too light. The colour is exactly as shown.",
    rating: 5,
    is_active: true,
    product_slug: "chocolate-knit-coord-set"
  },
  %{
    name: "Zawadi B.",
    position: 8,
    image: "/images/main.jpeg",
    body:
      "Ordered the Navy Pinstripe Blazer and I am in love. It looks so polished and professional but also very stylish. The fit is fantastic and I've already worn it three times this week!",
    rating: 5,
    is_active: true,
    product_slug: "navy-pinstripe-blazer"
  }
]

Enum.each(testimonials, fn attrs ->
  {product_slug, attrs} = Map.pop(attrs, :product_slug)
  product = get_product.(product_slug)

  {:ok, _} =
    %Testimonial{}
    |> Testimonial.changeset(Map.put(attrs, :product_id, product.id))
    |> Repo.insert()
end)

IO.puts("✅  Seeded #{length(testimonials)} testimonials.")
