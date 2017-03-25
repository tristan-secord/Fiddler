defmodule Fiddler.Router do
  use Fiddler.Web, :router

  scope "/graphiql", Fiddler do
    get "/", Absinthe.Plug.GraphiQL, schema: Fiddler.Schema
  end

end
