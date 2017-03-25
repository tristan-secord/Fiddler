defmodule Fiddler.Repo.Migrations.CreateNetwork do
  use Ecto.Migration

  def change do
    create table(:networks) do
      add :name, :string
      add :discoverable, :boolean, default: false, null: false
      add :latitude, :float
      add :longitude, :float
      add :bssid, :string
      add :password_hash, :string

      timestamps()
    end

  end
end
