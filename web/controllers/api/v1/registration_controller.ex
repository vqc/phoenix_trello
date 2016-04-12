#web/controllers/api/v1/registration_controller.ex

defmodule PhoenixTrello.RegistrationController do
  #"use" calls the __using__ macro on the specified module
  #so each module will handle "use" differently
  #here, we're telling this module to call the __using__ macro
  #from PhoenixTrello.web, and passing in the ":controllers"
  #which then causes PhoenixTrello.web to use the controllers module
  use PhoenixTrello.Web, :controller

  #alias PhoenixTrello.Repo as Repo
  #when no "as" is used, sets the alias automatically to the last part
  #of the module name
  alias PhoenixTrello.{Repo, User}

  #controllers also have plug pipelines, just like routers.
  plug :scrub_params, "user" when action in [:create]

  #'conn' is a struct which holds information about the request such as
  #the host, path elements, port, query string, and much more.
  #'conn', comes to Phoenix via Elixir's Plug middleware framework.
  #More detailed info about conn can be found in plug's documentation

  #The '%{}' is an elixir map, it is a key value store

  #Due to pattern matching, 'create' expects a 'user' key inside user_params

  def create(conn, %{"user" => user_params}) do
    #a changeset is an exlir struct that stores a set of changes (as well as
    #the validation rules). You pass a changeset to your Ecto Repo to persist
    #the changes if they are valid.
    #create a changeset from the User model with an empty
    #User struct and an empty map of parameters
    #a struct is an extension of a map
    changeset = User.changeset(%User{}, user_params)

    #case allows us to compare a value against many patterns
    #until a matching one is found
    #If Repo.insert(changeset) returns an :ok, do something, if it returns
    #:error, do something else.
    case Repo.insert(changeset) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user, :token)

        conn
        |> put_status(:created)
        |> render(PhoenixTrello.SessionView, "show.json", jwt: jwt, user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixTrello.RegistrationView, "error.json", changeset: changeset)

    end
  end

end
