defmodule Fiddler.Repo.Migrations.CreateUsersNetworks do
  use Ecto.Migration

  def change do
    create table(:users_networks, primary_key: false) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :network_id, references(:networks, on_delete: :delete_all)
    end
  end
end
