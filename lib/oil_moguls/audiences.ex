defmodule OilMoguls.Audiences do
  @moduledoc """
  The thirteen people and organisations Oil Moguls is built for.
  """

  def all do
    [
      %{
        name: "Students",
        body: "Break into the industry before graduation, with real career paths and people who already do the work."
      },
      %{
        name: "Fresh graduates",
        body: "Turn theory into an employable skill set, and get past the experience-required catch-22."
      },
      %{
        name: "Engineers",
        body: "Deepen technical specialisation and move toward senior or lead roles with practice-relevant learning."
      },
      %{
        name: "Geoscientists",
        body: "Access specialised training and a peer community that is otherwise small and hard to find locally."
      },
      %{
        name: "Procurement professionals",
        body: "Build supplier networks and stay current on contracting and compliance, with structured development."
      },
      %{
        name: "HSE professionals",
        body: "Keep certifications current and stay sharp on regulation and safety practice that actually holds up."
      },
      %{
        name: "Field operators",
        body: "Upskill toward supervisory roles with practical training that respects rotation schedules and field reality."
      },
      %{
        name: "Executives",
        body: "See the talent pipeline, stay ahead of workforce trends, and have a serious room for thought leadership."
      },
      %{
        name: "Consultants",
        body: "Build visible expertise, generate leads, and work among peers instead of in isolation."
      },
      %{
        name: "Service companies",
        body: "Reach qualified professionals and build an employer presence inside a high-signal community, not a job dump."
      },
      %{
        name: "Investors",
        body: "Follow credible workforce and energy-adjacent signals from a community that lives in the sector."
      },
      %{
        name: "Industry trainers",
        body: "Reach a verified learner base and be recognised as an expert, with distribution the industry actually uses."
      },
      %{
        name: "Regulators",
        body: "Engage a credible, organised channel to the professional community, with better visibility into real competence."
      }
    ]
  end

  def names, do: Enum.map(all(), & &1.name)
end
