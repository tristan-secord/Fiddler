defmodule Fiddler.Router do
  use Fiddler.Web, :router

  pipeline :graphql do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug Fiddler.Web.Context
  end

  scope "/" do
    pipe_through :graphql

    get "/graphiql", Absinthe.Plug.GraphiQL, schema: Fiddler.Schema
    post "/graphiql", Absinthe.Plug.GraphiQL, schema: Fiddler.Schema
    forward "/graphql", Absinthe.Plug, schema: Fiddler.Schema
  end
end
