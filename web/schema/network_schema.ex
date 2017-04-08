defmodule Fiddler.Schema.NetworkSchema do
  use Absinthe.Schema
  import_types Fiddler.Schema.UserSchema
  alias Fiddler.NetworkResolver

  # Queries
  object :network_queries do
    field :networks, list_of(:network_query) do
      arg :latitude, non_null(:float)
      arg :longitude, non_null(:float)
      arg :city, non_null(:string)

      resolve &NetworkResolver.all/2
    end
  end

  # Mutations
  object :network_mutations do
    field :create_network, type: :network do
      arg :name, non_null(:string)
      arg :discoverable, non_null(:boolean)
      arg :latitude, non_null(:float)
      arg :longitude, non_null(:float)
      arg :bssid, non_null(:string)
      arg :password, non_null(:string)
      arg :city, non_null(:string)

      resolve &NetworkResolver.create_network/2
    end
  end
end
