defmodule PhoenixTrello.Router do
  use PhoenixTrello.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  #pipeline :api do
  #  plug :accepts, ["json"]
  #end

  scope "/", PhoenixTrello do
    pipe_through :browser # Use the default browser stack

    #get "/", PageController, :index
    #manage routing on the front end, so tell Phoenix
    #to handle any http request through the index action of the PageController
    #which renders the main layout and the Root component
    #note that using hashhistory might be an option
    #but here, all paths will render the index.html
    get "*path", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixTrello do
  #   pipe_through :api
  # end
end
