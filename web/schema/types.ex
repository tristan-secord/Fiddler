defmodule Fiddler.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Fiddler.Repo

  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :networks, list_of(:network), resolve: assoc(:networks)
  end

  object :network do
    field :name, :string
    field :discoverable, :boolean
    field :latitude, :float
    field :longitude, :float
    field :bssid, :string
  end

  object :session do
    field :token, :string
  end
end
