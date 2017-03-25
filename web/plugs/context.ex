defmodule Fiddler.Web.Context do
  @behaviour Plug

  import Plug.Conn
  import Ecto.Query, only: [where: 2]

  def init(opts), do: opts

  def call(conn, _) do
    case Guardian.Plug.current_resource(conn) do
      nil -> conn
      user ->
        put_private(conn, :absinthe, %{context: %{current_user: user}})
    end
  end
end
