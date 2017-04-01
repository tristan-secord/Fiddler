defmodule Fiddler.Schema.UserSchema do
  use Absinthe.Schema
  import_types Fiddler.Schema.Types
  alias Fiddler.UserResolver

  # Mutations
  object :user_mutations do
    field :login, type: :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &UserResolver.login/2
    end

    field :signup, type: :session do
      arg :email, non_null(:string)
      arg :name, non_null(:string)
      arg :password, non_null(:string)

      resolve &UserResolver.signup/2
    end
  end
end
