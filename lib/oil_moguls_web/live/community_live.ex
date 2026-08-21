defmodule OilMogulsWeb.CommunityLive do
  use OilMogulsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, "Community")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.page_hero kicker="Community" title="A professional network with standards.">
      Every member here is building a career in or around oil and gas. Oil Moguls is the community they join, not a company that operates in the field.
    </.page_hero>

    <section class="py-16 sm:py-24">
      <div class="om-container grid gap-12 lg:grid-cols-2 lg:items-start">
        <.section_heading kicker="The standard" title="Competence is currency.">
          Follower counts do not run this community. Verified credentials, demonstrated skill, and contribution do.
        </.section_heading>
        <div class="space-y-8">
          <p class="om-body text-base sm:text-lg">
            Informal networks left access to chance. Oil Moguls engineers mentorship and introductions so you are not dependent on who you already know.
          </p>
          <p class="om-body">
            Moderation is visible. Community standards are enforced. That is how trust stays non-negotiable as the network grows.
          </p>
        </div>
      </div>
    </section>

    <section class="border-y border-line bg-white py-16 sm:py-24">
      <div class="om-container">
        <.section_heading kicker="What you join" title="Mentorship, peers, and a room worth being in." />
        <div class="mt-12 grid gap-4 md:grid-cols-3">
          <.feature_card icon="hero-chat-bubble-left-right" title="Verified mentors">
            People who have sat through a well-control course and a procurement negotiation. They share what they know instead of protecting it.
          </.feature_card>
          <.feature_card icon="hero-users" title="Peer community">
            Students, graduates, engineers, geoscientists, operators, HSE and procurement professionals, executives, consultants, trainers, and the institutions around them.
          </.feature_card>
          <.feature_card icon="hero-shield-check" title="Trust you can see">
            Verification badges on mentors and members. No fake experts. No unverified rooms dressed up as access.
          </.feature_card>
        </div>
      </div>
    </section>

    <section class="bg-night py-16 text-offwhite sm:py-24">
      <div class="om-container max-w-3xl">
        <p class="om-eyebrow om-eyebrow-light">Community compounds</p>
        <h2 class="om-display om-display-light mt-5 text-3xl sm:text-4xl">
          Every member who joins should make the platform more valuable for everyone already there.
        </h2>
        <p class="mt-6 text-offwhite/70">
          That is the design test. If a feature only extracts attention, it does not belong here.
        </p>
        <.link navigate="/join" class="om-btn om-btn-sage mt-8">Become a member</.link>
      </div>
    </section>
    """
  end
end
