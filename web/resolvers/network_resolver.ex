defmodule Fiddler.NetworkResolver do
  import Ecto.Query
  alias Fiddler.{Repo, Network}

  def all(_args, %{context: %{current_user: %{id: id}}}) do
    networks =
      Network
      |> Repo.all

    {:ok, networks}
  end
  def all(_args, _info), do: {:error, "Not Authorized."}
end
