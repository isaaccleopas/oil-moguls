defmodule OilMogulsWeb.JoinLive do
  use OilMogulsWeb, :live_view

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Join")
     |> assign(:submitted, false)
     |> assign(:errors, %{})
     |> assign(:form, %{"name" => "", "email" => "", "role" => "", "intent" => "", "note" => ""})}
  end

  @impl true
  def handle_event("validate", %{"member" => params}, socket) do
    {:noreply, assign(socket, form: params, errors: validate(params))}
  end

  def handle_event("join", %{"member" => params}, socket) do
    errors = validate(params)

    if errors == %{} do
      Logger.info("Oil Moguls join request: #{inspect(Map.take(params, ["name", "email", "role", "intent"]))}")

      {:noreply,
       socket
       |> assign(:submitted, true)
       |> assign(:form, params)
       |> assign(:errors, %{})}
    else
      {:noreply, assign(socket, form: params, errors: errors)}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.page_hero kicker="Join" title="Request access to the community.">
      Tell us which of the thirteen audiences you belong to. We will follow up with Academy, ApexBee, Conference, or the right room, not a company sales pitch.
    </.page_hero>

    <section class="py-16 sm:py-24">
      <div class="om-container grid gap-12 lg:grid-cols-[minmax(0,1fr)_minmax(0,1.1fr)]">
        <div>
          <h2 class="om-display text-2xl sm:text-3xl">Members of a learning community. That is the point.</h2>
          <p class="om-body mt-4">
            Oil Moguls is not an oil and gas company. You join as a student, a professional, a trainer, a service company, an investor, or a regulator, as a member of the same community.
          </p>
          <ul class="mt-8 space-y-4 text-sm text-night">
            <li class="flex gap-3"><.icon name="hero-check" class="mt-0.5 size-4 text-sage" /> Students, graduates, engineers, geoscientists, operators</li>
            <li class="flex gap-3"><.icon name="hero-check" class="mt-0.5 size-4 text-sage" /> HSE, procurement, executives, consultants</li>
            <li class="flex gap-3"><.icon name="hero-check" class="mt-0.5 size-4 text-sage" /> Service companies, investors, industry trainers, regulators</li>
          </ul>
        </div>

        <div class="om-card p-6 sm:p-8">
          <div :if={@submitted} class="space-y-3">
            <p class="font-mono text-xs tracking-[0.18em] uppercase text-muted">Received</p>
            <h3 class="text-xl font-semibold text-forest">Thank you, {@form["name"]}.</h3>
            <p class="om-body text-sm">
              We have your request. A member of the team will follow up at {@form["email"]} with the next step for your path.
            </p>
          </div>

          <form
            :if={!@submitted}
            id="join-form"
            phx-change="validate"
            phx-submit="join"
            class="space-y-5"
          >
            <.field
              name="member[name]"
              label="Full name"
              value={@form["name"]}
              error={@errors[:name]}
              autocomplete="name"
            />
            <.field
              name="member[email]"
              label="Email"
              type="email"
              value={@form["email"]}
              error={@errors[:email]}
              autocomplete="email"
            />
            <div>
              <label class="mb-2 block text-sm font-medium text-forest" for="member_role">Your role</label>
              <select id="member_role" name="member[role]" class={["om-input", @errors[:role] && "om-input-error"]}>
                <option value="">Select one</option>
                <option :for={role <- roles()} value={role} selected={@form["role"] == role}>{role}</option>
              </select>
              <p :if={@errors[:role]} class="mt-1 text-sm text-danger">{@errors[:role]}</p>
            </div>
            <div>
              <label class="mb-2 block text-sm font-medium text-forest" for="member_intent">What you need</label>
              <select id="member_intent" name="member[intent]" class={["om-input", @errors[:intent] && "om-input-error"]}>
                <option value="">Select one</option>
                <option :for={intent <- intents()} value={intent} selected={@form["intent"] == intent}>
                  {intent}
                </option>
              </select>
              <p :if={@errors[:intent]} class="mt-1 text-sm text-danger">{@errors[:intent]}</p>
            </div>
            <div>
              <label class="mb-2 block text-sm font-medium text-forest" for="member_note">Anything we should know</label>
              <textarea
                id="member_note"
                name="member[note]"
                rows="4"
                class="om-input min-h-28"
              >{@form["note"]}</textarea>
            </div>
            <button type="submit" class="om-btn om-btn-primary w-full">Submit request</button>
          </form>
        </div>
      </div>
    </section>
    """
  end

  attr :name, :string, required: true
  attr :label, :string, required: true
  attr :value, :string, default: ""
  attr :error, :string, default: nil
  attr :type, :string, default: "text"
  attr :autocomplete, :string, default: "on"

  defp field(assigns) do
    ~H"""
    <div>
      <label class="mb-2 block text-sm font-medium text-forest">{@label}</label>
      <input
        type={@type}
        name={@name}
        value={@value}
        autocomplete={@autocomplete}
        class={["om-input", @error && "om-input-error"]}
      />
      <p :if={@error} class="mt-1 text-sm text-danger">{@error}</p>
    </div>
    """
  end

  defp validate(params) do
    %{}
    |> put_error(:name, blank?(params["name"]), "Enter your name.")
    |> put_error(:email, invalid_email?(params["email"]), "Enter a valid email.")
    |> put_error(:role, blank?(params["role"]), "Select your role.")
    |> put_error(:intent, blank?(params["intent"]), "Select what you need.")
  end

  defp put_error(errors, _key, false, _message), do: errors
  defp put_error(errors, key, true, message), do: Map.put(errors, key, message)

  defp blank?(nil), do: true
  defp blank?(value), do: String.trim(value) == ""

  defp invalid_email?(nil), do: true
  defp invalid_email?(value), do: blank?(value) or not String.contains?(value, "@")

  defp roles, do: OilMoguls.Audiences.names()

  defp intents do
    [
      "Join the Academy",
      "Use ApexBee",
      "Find a mentor",
      "See verified opportunities",
      "Attend the Conference",
      "Join as a trainer",
      "Join as a service company",
      "Join as an investor or regulator"
    ]
  end
end
