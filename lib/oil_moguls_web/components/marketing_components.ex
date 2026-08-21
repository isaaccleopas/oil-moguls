defmodule OilMogulsWeb.MarketingComponents do
  @moduledoc """
  Shared marketing UI: wordmark, navigation, footer, and section primitives.
  """
  use Phoenix.Component

  alias Phoenix.LiveView.JS

  attr :variant, :string, default: "forest", values: ["forest", "light"]
  attr :class, :any, default: nil

  def wordmark(assigns) do
    ~H"""
    <span class={["inline-flex items-center gap-1.5", @class]}>
      <span class={[
        "text-[0.95rem] font-bold tracking-tight leading-none sm:text-base",
        @variant == "light" && "text-offwhite",
        @variant == "forest" && "text-forest"
      ]}>
        OIL
      </span>
      <.drill_point class="h-3.5 w-2.5 shrink-0 sm:h-4 sm:w-3" />
      <span class={[
        "text-[0.95rem] font-light tracking-[0.18em] leading-none sm:text-base",
        @variant == "light" && "text-offwhite",
        @variant == "forest" && "text-forest"
      ]}>
        MOGULS
      </span>
    </span>
    """
  end

  attr :class, :any, default: "h-4 w-3"

  def drill_point(assigns) do
    ~H"""
    <svg class={@class} viewBox="0 0 24 32" fill="none" aria-hidden="true">
      <path d="M12 1.2 22.8 16 12 30.8 1.2 16 12 1.2Z" fill="#8FCDA5" />
      <path d="M12 1.2 12 30.8 1.2 16 12 1.2Z" fill="#0E3020" fill-opacity="0.22" />
      <path d="M12 1.2 22.8 16 12 16 12 1.2Z" fill="#F2F6F1" fill-opacity="0.28" />
    </svg>
    """
  end

  attr :current_path, :string, default: "/"

  def site_nav(assigns) do
    ~H"""
    <header class="sticky top-0 z-40 border-b border-line/80 bg-offwhite/92 backdrop-blur-md">
      <div class="om-container flex h-16 items-center justify-between gap-4 lg:h-[4.5rem]">
        <.link navigate="/" class="shrink-0" aria-label="Oil Moguls home">
          <.wordmark />
        </.link>

        <nav class="hidden items-center gap-7 lg:flex" aria-label="Primary">
          <.nav_link
            :for={item <- nav_items()}
            current_path={@current_path}
            href={item.href}
            external={item.external}
          >
            {item.label}
          </.nav_link>
        </nav>

        <div class="hidden items-center gap-3 lg:flex">
          <.link navigate="/audiences" class="om-nav-link">Who we serve</.link>
          <.link navigate="/join" class="om-btn om-btn-primary">Join the community</.link>
        </div>

        <button
          type="button"
          class="inline-flex size-11 items-center justify-center text-forest lg:hidden"
          phx-click={toggle_menu()}
          aria-controls="mobile-nav"
          aria-expanded="false"
          aria-label="Open menu"
        >
          <.icon name="hero-bars-3" class="menu-icon-closed size-6" />
          <.icon name="hero-x-mark" class="menu-icon-open hidden size-6" />
        </button>
      </div>

      <div id="mobile-nav" class="hidden border-t border-line bg-offwhite lg:hidden">
        <nav class="om-container flex flex-col gap-1 py-4" aria-label="Mobile">
          <%= for item <- nav_items() do %>
            <%= if item.external do %>
              <.link
                href={item.href}
                target="_blank"
                rel="noopener noreferrer"
                class="flex min-h-11 items-center text-base font-medium text-night"
                phx-click={toggle_menu()}
              >
                {item.label}
              </.link>
            <% else %>
              <.link
                navigate={item.href}
                class="flex min-h-11 items-center text-base font-medium text-night"
                phx-click={toggle_menu()}
              >
                {item.label}
              </.link>
            <% end %>
          <% end %>
          <.link
            navigate="/audiences"
            class="flex min-h-11 items-center text-base font-medium text-night"
            phx-click={toggle_menu()}
          >
            Who we serve
          </.link>
          <.link navigate="/join" class="om-btn om-btn-primary mt-3 w-full" phx-click={toggle_menu()}>
            Join the community
          </.link>
        </nav>
      </div>
    </header>
    """
  end

  attr :current_path, :string, required: true
  attr :href, :string, required: true
  attr :external, :boolean, default: false
  slot :inner_block, required: true

  defp nav_link(assigns) do
    ~H"""
    <.link
      :if={@external}
      href={@href}
      target="_blank"
      rel="noopener noreferrer"
      class="om-nav-link"
    >
      {render_slot(@inner_block)}
    </.link>
    <.link
      :if={!@external}
      navigate={@href}
      class="om-nav-link"
      data-active={to_string(active?(@current_path, @href))}
    >
      {render_slot(@inner_block)}
    </.link>
    """
  end

  def site_footer(assigns) do
    ~H"""
    <footer class="bg-night text-offwhite">
      <div class="om-container grid gap-10 py-16 sm:grid-cols-2 lg:grid-cols-4 lg:gap-12 lg:py-20">
        <div class="sm:col-span-2 lg:col-span-1">
          <.wordmark variant="light" />
          <p class="om-body mt-5 max-w-xs text-sm text-offwhite/70">
            A learning community for oil and gas professionals, not an oil and gas company. Knowledge, practice, and access in one place.
          </p>
        </div>

        <div>
          <p class="text-xs font-medium tracking-[0.18em] uppercase text-offwhite/50">Products</p>
          <ul class="mt-4 space-y-3 text-sm">
            <li><.link navigate="/academy" class="text-offwhite/80 hover:text-sage">Academy</.link></li>
            <li>
              <.link href={OilMoguls.apexbee_url()} target="_blank" rel="noopener noreferrer" class="text-offwhite/80 hover:text-sage">
                ApexBee
              </.link>
            </li>
            <li><.link navigate="/community" class="text-offwhite/80 hover:text-sage">Community</.link></li>
            <li>
              <.link navigate="/opportunities" class="text-offwhite/80 hover:text-sage">
                Opportunity Board
              </.link>
            </li>
            <li>
              <.link navigate="/conference" class="text-offwhite/80 hover:text-sage">Conference</.link>
            </li>
          </ul>
        </div>

        <div>
          <p class="text-xs font-medium tracking-[0.18em] uppercase text-offwhite/50">Community</p>
          <ul class="mt-4 space-y-3 text-sm">
            <li><.link navigate="/audiences" class="text-offwhite/80 hover:text-sage">Who we serve</.link></li>
            <li><.link navigate="/about" class="text-offwhite/80 hover:text-sage">About</.link></li>
            <li><.link navigate="/join" class="text-offwhite/80 hover:text-sage">Join</.link></li>
          </ul>
        </div>

        <div>
          <p class="text-xs font-medium tracking-[0.18em] uppercase text-offwhite/50">Tagline</p>
          <p class="mt-4 text-sm leading-relaxed text-offwhite/80">
            Access is earned. We make sure it's possible.
          </p>
        </div>
      </div>

      <div class="border-t border-white/10">
        <div class="om-container flex flex-col gap-2 py-6 text-xs text-offwhite/45 sm:flex-row sm:items-center sm:justify-between">
          <p>© {Date.utc_today().year} Oil Moguls. A learning community. Built for Africa.</p>
          <p class="font-mono">Not an oil company. Built for oil and gas professionals.</p>
        </div>
      </div>
    </footer>
    """
  end

  attr :kicker, :string, required: true
  attr :title, :string, required: true
  attr :light, :boolean, default: false
  slot :inner_block

  def section_heading(assigns) do
    ~H"""
    <div class="max-w-2xl">
      <p class={["om-eyebrow", @light && "om-eyebrow-light"]}>{@kicker}</p>
      <h2 class={[
        "om-display mt-5 text-3xl sm:text-4xl",
        @light && "om-display-light"
      ]}>
        {@title}
      </h2>
      <div :if={@inner_block != []} class={["om-body mt-4 text-base sm:text-lg", @light && "text-offwhite/70"]}>
        {render_slot(@inner_block)}
      </div>
    </div>
    """
  end

  attr :icon, :string, required: true
  attr :title, :string, required: true
  slot :inner_block, required: true

  def feature_card(assigns) do
    ~H"""
    <article class="om-card p-6 sm:p-8">
      <div class="flex size-10 items-center justify-center border border-line text-forest">
        <.icon name={@icon} class="size-5" />
      </div>
      <h3 class="mt-5 text-lg font-semibold text-forest">{@title}</h3>
      <p class="om-body mt-3 text-sm">{render_slot(@inner_block)}</p>
    </article>
    """
  end

  attr :value, :string, required: true
  attr :label, :string, required: true

  def proof_stat(assigns) do
    ~H"""
    <div class="border-t border-white/15 pt-5">
      <p class="font-mono text-2xl font-medium text-sage sm:text-3xl">{@value}</p>
      <p class="mt-2 text-sm text-offwhite/70">{@label}</p>
    </div>
    """
  end

  attr :kicker, :string, default: "Oil Moguls"
  attr :title, :string, required: true
  slot :inner_block, required: true

  def page_hero(assigns) do
    ~H"""
    <section class="om-hero-mesh relative overflow-hidden">
      <div class="om-container relative z-10 py-16 sm:py-20 lg:py-24">
        <p class="om-eyebrow om-eyebrow-light">{@kicker}</p>
        <h1 class="om-display om-display-light mt-5 max-w-3xl text-4xl sm:text-5xl lg:text-[3.25rem]">
          {@title}
        </h1>
        <p class="mt-5 max-w-xl text-base leading-relaxed text-offwhite/75 sm:text-lg">
          {render_slot(@inner_block)}
        </p>
      </div>
    </section>
    """
  end

  defp icon(assigns) do
    OilMogulsWeb.CoreComponents.icon(assigns)
  end

  defp nav_items do
    [
      %{label: "Academy", href: "/academy", external: false},
      %{label: "ApexBee", href: OilMoguls.apexbee_url(), external: true},
      %{label: "Community", href: "/community", external: false},
      %{label: "Opportunities", href: "/opportunities", external: false},
      %{label: "Conference", href: "/conference", external: false}
    ]
  end

  defp active?("/", "/"), do: true
  defp active?(current, href) when href != "/", do: current == href or String.starts_with?(current, href)
  defp active?(_, _), do: false

  defp toggle_menu do
    JS.toggle(to: "#mobile-nav")
    |> JS.toggle_class("hidden", to: ".menu-icon-closed")
    |> JS.toggle_class("hidden", to: ".menu-icon-open")
    |> JS.toggle_attribute({"aria-expanded", "true", "false"})
  end
end
