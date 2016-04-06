#$ mix ecto.create
#$ mix phoenix.gen.model User users first_name:string last_name:string email:string encrypted_password:string
#then add null restrictions to the fields
#and enforce uniqueness on email

defmodule PhoenixTrello.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :email, :string, null: false
      add :encrypted_password, :string, null: false

      timestamps
    end

    create unique_index(:users, [:email])
    #also e.g. to enforce unique username if you had usernames in :users
    #create unique_index(:users, [:username])

  end
end

#and then run ecto.migrate to create the table
