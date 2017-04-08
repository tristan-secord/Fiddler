defmodule Fiddler.Repo.Migrations.AddIndexAndCityToNetworks do
  use Ecto.Migration

  def change do
    create unique_index(:networks, [:bssid])
    alter table :networks do
      add :city, :string
    end
  end
end
