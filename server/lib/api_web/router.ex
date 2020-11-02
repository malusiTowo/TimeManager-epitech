defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: "*"
    plug CORSPlug, send_preflight_response?: false
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  pipeline :authenticated do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/api", ApiWeb do
    pipe_through :api

    post "/sign_up", RegistrationController, :sign_up
    post "/sign_in", SessionController, :sign_in

    pipe_through :authenticated # restrict unauthenticated access for routes below

    resources "/teams", TeamController, except: [:new, :edit]
    resources "/team_users", TeamUserController, except: [:new, :edit]

    resources "/users", UserController, except: [:new, :edit]

    put "/workingtimes/:id", WorkingtimesController, :update
    delete "/workingtimes/:id", WorkingtimesController, :delete

    scope "/workingtimes" do
      get "/:userId/:workingId", WorkingtimesController, :getWorkingTimesByUserIdAndWorkingId
      get "/:userId", WorkingtimesController, :getWorkingTimes
      post "/:userId", WorkingtimesController, :createWorkingTimeForUser
      put "/:id", WorkingtimesController, :update
      delete "/:id", WorkingtimesController, :delete
      post "/", WorkingtimesController, :create
    end


    scope "/clocks" do
      post "/admin/:userId", ClockController, :createClockForUser
      get "/:userId", ClockController, :getClocksForUser
      post "/:userId", ClockController, :clockUserIn
      post "/", ClockController, :createClockForUser
      delete "/:id", ClockController, :delete
    end

  end


  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ApiWeb.Telemetry
    end
  end
end
