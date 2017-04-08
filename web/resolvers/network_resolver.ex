defmodule Fiddler.NetworkResolver do
  import Ecto.Query
  alias Fiddler.{Repo, Network}

  def all(args, %{context: %{current_user: %{id: _id}}}) do
    networks =
      Network
      |> Network.by_city(args)
      |> where([n], n.discoverable == true)
      |> Repo.all()
      |> Network.by_location(args)

    {:ok, networks}
  end
  def all(_args, _info), do: {:error, "Not Authorized"}

  def create_network(args, %{context: %{current_user: %{id: id}}}) do
    params = Map.put(args, :user_id, id)

    network =
      %Network{}
      |> Network.registration_changeset(params)
      |> Repo.insert!

    {:ok, network}
  end
  def create(_args, _info), do: {:error, "Not Authorized"}
end
