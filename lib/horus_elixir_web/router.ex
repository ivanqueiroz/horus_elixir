defmodule HorusElixirWeb.Router do
  use HorusElixirWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/horus", HorusElixirWeb do
    pipe_through :api

    get "/", WelcomeController, :index
    get "/convert", TransactionsController, :convert
    get "/transactions", TransactionsController, :show_by_user_id
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:horus_elixir, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: HorusElixirWeb.Telemetry
    end
  end
end
