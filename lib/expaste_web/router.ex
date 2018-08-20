defmodule ExpasteWeb.Router do
  use ExpasteWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExpasteWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PasteController, :index
    get "/paste", PasteController, :latest
    post "/paste", PasteController, :save
    get "/paste/:id", PasteController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", ExpasteWeb do
  #   pipe_through :api
  # end
end
