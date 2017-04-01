defmodule Fiddler.Schema do
  use Absinthe.Schema
  import_types Fiddler.Schema.NetworkSchema

  query do
    import_fields :network_queries
  end

  mutation do
    import_fields :user_mutations
    import_fields :network_mutations
  end
end
