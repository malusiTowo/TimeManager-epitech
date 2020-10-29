defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug CORSPlug, send_preflight_response?: false
    plug :accepts, ["json"]
  end

  scope "/api", ApiWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    # resources "/workingtimes", WorkingtimesController, except: [:new, :edit]
    # resources "/clocks", ClockController, except: [:new, :edit]



    # post "/workingtimes/:userId", WorkingtimesController, :createWorkingTimeForUser
    # get "/workingtimes/:userId/:workingId", WorkingtimesController, :getWorkingTimesByUserIdAndWorkingId
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
