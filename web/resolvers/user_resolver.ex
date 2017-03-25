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
    %User{}
    |> User.registration_changeset(args)
    |> Repo.insert
  end
end
