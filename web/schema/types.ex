defmodule Fiddler.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Fiddler.Repo

  # Objects
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :networks, list_of(:network), resolve: assoc(:networks)
  end

  object :network do
    field :name, :string
    field :discoverable, :boolean
  end

  object :network_query do
    field :name, :string
    field :distance, :float
  end

  object :session do
    field :token, :string
  end

  # Input Objects
  input_object :update_user_params do
    field :name, :string
    field :email, :string
    field :password, :string
  end

  input_object :update_network_params do
    field :name, :string
    field :discoverable, :boolean
    field :latitude, :float
    field :longitude, :float
    field :bssid, :string
    field :password, :string
  end
end
