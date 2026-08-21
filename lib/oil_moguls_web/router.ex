defmodule OilMogulsWeb.Router do
  use OilMogulsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {OilMogulsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", OilMogulsWeb do
    pipe_through :browser

    live_session :public,
      on_mount: [OilMogulsWeb.LiveHooks],
      layout: {OilMogulsWeb.Layouts, :marketing} do
      live "/", HomeLive, :index
      live "/academy", AcademyLive, :index
      live "/apexbee", ApexBeeLive, :index
      live "/community", CommunityLive, :index
      live "/opportunities", OpportunitiesLive, :index
      live "/conference", ConferenceLive, :index
      live "/about", AboutLive, :index
      live "/audiences", AudiencesLive, :index
      live "/partners", AudiencesLive, :index
      live "/join", JoinLive, :index
    end
  end

  if Application.compile_env(:oil_moguls, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: OilMogulsWeb.Telemetry
    end
  end
end
