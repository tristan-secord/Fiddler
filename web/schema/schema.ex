defmodule Fiddler.Schema do
  use Absinthe.Schema
  import_types Fiddler.Schema.Types
  alias Fiddler.{NetworkResolver, UserResolver}

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

  query do
    field :networks, list_of(:network) do
      resolve &NetworkResolver.all/2
    end
  end

  mutation do
    field :login, type: :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &UserResolver.login/2
    end

    field :signup, type: :user do
      arg :email, non_null(:string)
      arg :name, non_null(:string)
      arg :password, non_null(:string)

      resolve &UserResolver.signup/2
    end
  end
end
