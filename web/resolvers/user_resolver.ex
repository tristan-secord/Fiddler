defmodule Fiddler.UserResolver do
  alias Fiddler.Repo
  alias Fiddler.User

  def login(params, _info) do
    with {:ok, user} <- Fiddler.Session.authenticate(params, Repo),
    {:ok, jwt, _} <- Guardian.encode_and_sign(user, :access) do
      {:ok, %{token: jwt}}
    end
  end

  def signup(args, _info) do
    user =
      %User{}
      |> User.registration_changeset(args)

    case (Repo.insert(user)) do
      {:error, changeset} ->
        {:error, get_first_error(changeset)}
      {:ok, user} ->
        login(user, %{})
    end
  end

  defp get_first_error(nil), do: "Something went wrong. Please try again."
  defp get_first_error(changeset) do
    case changeset.errors do
      [{_field, {msg, _opts}} | _rest] -> msg
      nil -> "Something went wrong. Please try again."
    end
  end
end
