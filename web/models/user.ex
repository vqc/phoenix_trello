#created after creating a migration file (see priv/repo/migrations)
#then running ecto.migrate
defmodule PhoenixTrello.User do
  use PhoenixTrello.Web, :model

  #the schema block has the metadat regarding table fields
  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    #virtual password field that will not be inserted into the db
    #but can be used as any other field for any other purpose
    #will be populated from the sign up form
    field :password, :string, virtual: true
    field :encrypted_password, :string

    timestamps
  end

  #make the password field required
  @required_fields ~w(first_name last_name email password)
  @optional_fields ~w(encrypted_password)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  #changeset function defines all the validations and transformations
  #applied to the data before being ready to use in the application
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    #validate :email with regex checking to see if it contains @
    |> validate_format(:email, ~r/@/)
    #password min length
    |> validate_length(:password, min: 5)
    #check password_confirmation has same value
    |> validate_confirmation(:password, message: "Password does not match")
    #unique constraint check
    |> unique_constraint(:email, message: "Email already taken")
    #generate encrypted Password
    |> generate_encrypted_password
  end

  defp generate_encrypted_password(current_changeset) do
    case current_changeset do
      #check if the current changeset is valid and if the password has changed
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        #if yes, encrypt the password using comeonin and put it in the
        #encrypted_password field of the changeset
        put_change(current_changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
        #else, just return the current changeset
      _ ->
        current_changeset
    end
  end

end
