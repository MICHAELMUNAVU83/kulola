defmodule KulolaWeb.SidebarComponents do
  use Phoenix.Component
  use KulolaWeb, :verified_routes

  @doc """
  The main admin sidebar wrapper.

  ## Example
      <.admin_sidebar current_path={@current_path} counts={@counts} />
  """
  def admin_sidebar(assigns) do
    assigns =
      assigns
      |> assign_new(:counts, fn -> %{} end)
      |> assign_new(:current_path, fn -> "/" end)

    ~H"""
    <aside class="flex h-screen w-[220px] flex-shrink-0 flex-col border-r border-gray-200 bg-white xl:w-[240px]">
      <.sidebar_logo />

      <nav class="flex-1 overflow-y-auto px-3 py-4 space-y-0.5">
        <.nav_section label="Overview" />

        <.nav_item label="Dashboard" path={~p"/admin"} active={@current_path == "/admin"} icon="grid" />

        <.nav_item
          label="Orders"
          path={~p"/admin/orders"}
          active={String.starts_with?(@current_path, "/admin/orders")}
          icon="cart"
          badge={Map.get(@counts, :orders)}
          badge_variant={:default}
        />

        <.nav_item
          label="Analytics"
          path={~p"/admin/analytics"}
          active={String.starts_with?(@current_path, "/admin/analytics")}
          icon="chart"
        />

        <.nav_divider />
        <.nav_section label="Catalogue" />

        <.nav_item
          label="Products"
          path={~p"/admin/products"}
          active={String.starts_with?(@current_path, "/admin/products")}
          icon="tag"
          badge={Map.get(@counts, :products)}
          badge_variant={:count}
        />

        <.nav_item
          label="Collections"
          path={~p"/admin/collections"}
          active={String.starts_with?(@current_path, "/admin/collections")}
          icon="layers"
          badge={Map.get(@counts, :collections)}
          badge_variant={:count}
        />

        <.nav_item
          label="Bundles"
          path={~p"/admin/bundles"}
          active={String.starts_with?(@current_path, "/admin/bundles")}
          icon="package"
          badge={Map.get(@counts, :bundles)}
          badge_variant={:count}
        />

        <.nav_item
          label="Testimonials"
          path={~p"/admin/testimonials"}
          active={String.starts_with?(@current_path, "/admin/testimonials")}
          icon="quote"
          badge={Map.get(@counts, :testimonials)}
          badge_variant={:count}
        />

        <.nav_divider />
        <.nav_section label="Store" />

        <.nav_item
          label="Promotions"
          path={~p"/admin/promotions"}
          active={String.starts_with?(@current_path, "/admin/promotions")}
          icon="badge"
        />

        <.nav_item
          label="Customers"
          path={~p"/admin/customers"}
          active={String.starts_with?(@current_path, "/admin/customers")}
          icon="users"
          badge={Map.get(@counts, :customers)}
          badge_variant={:count}
        />

        <.nav_item
          label="Homepage"
          path={~p"/admin/homepage"}
          active={String.starts_with?(@current_path, "/admin/homepage")}
          icon="monitor"
        />

        <.nav_divider />
        <.nav_section label="System" />

        <.nav_item
          label="Settings"
          path={~p"/admin/settings"}
          active={String.starts_with?(@current_path, "/admin/settings")}
          icon="settings"
        />
      </nav>

      <.sidebar_footer />
    </aside>
    """
  end

  # ── Logo ──────────────────────────────────────────────────────────

  defp sidebar_logo(assigns) do
    ~H"""
    <div class="flex items-center gap-2.5 border-b border-gray-200 px-4 py-4">
      <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-black">
        <svg
          class="h-4 w-4 text-white"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2.5"
        >
          <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
        </svg>
      </div>
      <span class="text-[17px] font-bold tracking-tight text-black">Dojeen.</span>
      <span class="ml-auto rounded-md bg-gray-100 px-1.5 py-0.5 text-[10px] font-semibold uppercase tracking-wide text-gray-500">
        Admin
      </span>
    </div>
    """
  end

  # ── Section Label ─────────────────────────────────────────────────

  defp nav_section(assigns) do
    ~H"""
    <p class="mb-1 mt-2 px-2 text-[10px] font-semibold uppercase tracking-widest text-gray-400">
      {@label}
    </p>
    """
  end

  # ── Divider ───────────────────────────────────────────────────────

  defp nav_divider(assigns) do
    ~H"""
    <div class="my-2 h-px bg-gray-100"></div>
    """
  end

  # ── Nav Item ──────────────────────────────────────────────────────

  @doc """
  A single sidebar nav link.

  ## Props
    - label       - display text
    - path        - href
    - active      - boolean
    - icon        - one of the icon keys below
    - badge       - integer or string, shown on right
    - badge_variant - :count | :alert (default :count)
  """
  defp nav_item(assigns) do
    assigns =
      assigns
      |> assign_new(:badge, fn -> nil end)
      |> assign_new(:badge_variant, fn -> :count end)
      |> assign_new(:active, fn -> false end)

    ~H"""
    <a
      href={@path}
      class={[
        "group flex items-center gap-2.5 rounded-lg px-2.5 py-2 text-[13px] font-medium transition-colors",
        if(@active,
          do: "bg-gray-900 text-white",
          else: "text-gray-600 hover:bg-gray-100 hover:text-gray-900"
        )
      ]}
    >
      <span class={if @active, do: "text-white", else: "text-gray-400 group-hover:text-gray-600"}>
        <.nav_icon name={@icon} />
      </span>

      {@label}

      <%= if @badge && @badge > 0 do %>
        <span class={[
          "ml-auto rounded-full px-2 py-0.5 text-[10px] font-semibold tabular-nums",
          if(@active,
            do: "bg-white/20 text-white",
            else: badge_class(@badge_variant)
          )
        ]}>
          {@badge}
        </span>
      <% end %>
    </a>
    """
  end

  defp badge_class(:alert), do: "bg-red-100 text-red-600"
  defp badge_class(:count), do: "bg-gray-100 text-gray-500"

  # ── Footer / User ─────────────────────────────────────────────────

  defp sidebar_footer(assigns) do
    ~H"""
    <div class="border-t border-gray-200 p-3">
      <div class="flex items-center gap-2.5 rounded-lg px-2 py-2 transition hover:bg-gray-100 cursor-pointer">
        <div class="flex h-8 w-8 flex-shrink-0 items-center justify-center rounded-full bg-gray-900 text-xs font-bold text-white">
          MM
        </div>
        <div class="min-w-0 flex-1">
          <p class="truncate text-[13px] font-semibold text-gray-900">Michael Munavu</p>
          <p class="text-[11px] text-gray-400">Super Admin</p>
        </div>
        <svg
          class="h-4 w-4 text-gray-400"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
        >
          <path d="M9 18l6-6-6-6" />
        </svg>
      </div>
    </div>
    """
  end

  # ── Icons ─────────────────────────────────────────────────────────

  defp nav_icon(%{name: "grid"} = assigns) do
    ~H"""
    <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <rect x="3" y="3" width="7" height="7" rx="1" />
      <rect x="14" y="3" width="7" height="7" rx="1" />
      <rect x="3" y="14" width="7" height="7" rx="1" />
      <rect x="14" y="14" width="7" height="7" rx="1" />
    </svg>
    """
  end

  defp nav_icon(%{name: "cart"} = assigns) do
    ~H"""
    <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <path d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
    </svg>
    """
  end

  defp nav_icon(%{name: "chart"} = assigns) do
    ~H"""
    <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <polyline points="22 12 18 12 15 21 9 3 6 12 2 12" />
    </svg>
    """
  end

  defp nav_icon(%{name: "tag"} = assigns) do
    ~H"""
    <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z" />
      <line x1="7" y1="7" x2="7.01" y2="7" />
    </svg>
    """
  end

  defp nav_icon(%{name: "layers"} = assigns) do
    ~H"""
    <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <polygon points="12 2 2 7 12 12 22 7 12 2" />
      <polyline points="2 17 12 22 22 17" />
      <polyline points="2 12 12 17 22 12" />
    </svg>
    """
  end

  defp nav_icon(%{name: "package"} = assigns) do
    ~H"""
    <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <line x1="16.5" y1="9.4" x2="7.5" y2="4.21" />
      <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z" />
      <polyline points="3.27 6.96 12 12.01 20.73 6.96" />
      <line x1="12" y1="22.08" x2="12" y2="12" />
    </svg>
    """
  end

  defp nav_icon(%{name: "star"} = assigns) do
    ~H"""
    <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" />
    </svg>
    """
  end

  defp nav_icon(%{name: "quote"} = assigns) do
    ~H"""
    <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <path d="M3 21c3 0 7-1 7-8V5c0-1.25-.756-2.017-2-2H4c-1.25 0-2 .75-2 1.972V11c0 1.25.75 2 2 2 1 0 1 0 1 1v1c0 1-1 2-2 2s-1 .008-1 1.031V20c0 1 0 1 1 1z" />
      <path d="M15 21c3 0 7-1 7-8V5c0-1.25-.757-2.017-2-2h-4c-1.25 0-2 .75-2 1.972V11c0 1.25.75 2 2 2h.75c0 2.25.25 4-2.75 4v3c0 1 0 1 1 1z" />
    </svg>
    """
  end

  defp nav_icon(%{name: "badge"} = assigns) do
    ~H"""
    <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <circle cx="12" cy="8" r="6" />
      <path d="M15.477 12.89L17 22l-5-3-5 3 1.523-9.11" />
    </svg>
    """
  end

  defp nav_icon(%{name: "users"} = assigns) do
    ~H"""
    <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" />
      <circle cx="9" cy="7" r="4" />
      <path d="M23 21v-2a4 4 0 0 0-3-3.87m-4-12a4 4 0 0 1 0 7.75" />
    </svg>
    """
  end

  defp nav_icon(%{name: "monitor"} = assigns) do
    ~H"""
    <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <rect x="2" y="3" width="20" height="14" rx="2" />
      <line x1="8" y1="21" x2="16" y2="21" />
      <line x1="12" y1="17" x2="12" y2="21" />
    </svg>
    """
  end

  defp nav_icon(%{name: "settings"} = assigns) do
    ~H"""
    <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <circle cx="12" cy="12" r="3" />
      <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z" />
    </svg>
    """
  end

  defp nav_icon(assigns) do
    ~H"""
    <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
      <circle cx="12" cy="12" r="10" />
    </svg>
    """
  end

  # ── Helpers ───────────────────────────────────────────────────────

  defp initials(nil), do: "A"

  defp initials(%{name: name}) when is_binary(name) do
    name
    |> String.split()
    |> Enum.take(2)
    |> Enum.map(&String.first/1)
    |> Enum.join()
    |> String.upcase()
  end

  defp initials(_), do: "A"

  defp admin_name(nil), do: "Admin"
  defp admin_name(%{name: name}), do: name
  defp admin_name(_), do: "Admin"
end
