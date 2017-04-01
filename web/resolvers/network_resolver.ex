defmodule Fiddler.NetworkResolver do
  alias Fiddler.{Repo, Network}

  def all(args, %{context: %{current_user: %{id: _id}}}) do
    Network
    |> Network.by_city(args)
    |> Network.by_location(args)
    |> Repo.all()
  end
  def all(_args, _info), do: {:error, "Not Authorized"}

  def create(args, %{context: %{current_user: %{id: id}}}) do
    params = Map.put(args, :user_id, id)

    %Network{}
    |> Network.registration_changeset(params)
    |> Repo.insert
  end
  def create(_args, _info), do: {:error, "Not Authorized"}
end
