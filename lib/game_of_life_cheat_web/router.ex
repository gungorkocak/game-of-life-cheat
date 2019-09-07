defmodule GameOfLifeCheatWeb.Router do
  use GameOfLifeCheatWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GameOfLifeCheatWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/game", GameLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", GameOfLifeCheatWeb do
  #   pipe_through :api
  # end
end
