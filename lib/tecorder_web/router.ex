defmodule TecorderWeb.Router do
  use TecorderWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", TecorderWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/cars", CarController)
    resources("/entries", EntryController)
    resources("/charges", ChargeController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", TecorderWeb do
  #   pipe_through :api
  # end
end
