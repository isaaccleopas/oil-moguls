defmodule OilMogulsWeb.ConferenceLive do
  use OilMogulsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, "Conference")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.page_hero kicker="The Oil Moguls Conference" title="Where the next generation of oil and gas professionals shows up to learn, connect, and get seen.">
      A gathering of the community, not an energy expo and not a company offsite. If you are serious about a career in this sector, this is the room.
    </.page_hero>

    <section class="py-16 sm:py-24">
      <div class="om-container grid gap-12 lg:grid-cols-2">
        <.section_heading kicker="Core product" title="The gathering that puts the community in one room.">
          The Conference is a flagship of Oil Moguls the learning community: the moment Academy, ApexBee, mentorship, and opportunity occupy the same physical space.
        </.section_heading>
        <div class="space-y-6 om-body">
          <p>
            Members meet operators, service companies, mentors, and peers with the same standard they already know on the platform: verified, specific, and built for people who do the work.
          </p>
          <p>
            Alongside the Conference, the Oil Moguls Incubator develops the next leaders of the community itself, so the standard scales without thinning.
          </p>
        </div>
      </div>
    </section>

    <section class="border-y border-line bg-white py-16 sm:py-24">
      <div class="om-container grid gap-4 md:grid-cols-3">
        <.feature_card icon="hero-microphone" title="Substance on stage">
          Technical sessions and career briefings from people inside the industry. No outsider keynotes dressed as insight.
        </.feature_card>
        <.feature_card icon="hero-hand-raised" title="Access you can use">
          Structured introductions, mentor hours, and hiring conversations with a vetted talent pool.
        </.feature_card>
        <.feature_card icon="hero-map-pin" title="Built for this market">
          Hosted where African oil and gas talent actually lives and works, starting with Nigeria.
        </.feature_card>
      </div>
    </section>

    <section class="py-16 sm:py-24">
      <div class="om-container flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">
        <div class="max-w-xl">
          <h2 class="om-display text-3xl">Reserve your place for the next gathering.</h2>
          <p class="om-body mt-3">
            Tell us who you are. We will follow up with dates, format, and the right ticket path, including groups from service companies, campuses, and professional bodies.
          </p>
        </div>
        <.link navigate="/join" class="om-btn om-btn-primary">Register interest</.link>
      </div>
    </section>
    """
  end
end
