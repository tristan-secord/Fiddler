defmodule Fiddler.User do
  use Fiddler.Web, :model
  alias Fiddler.Network

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    many_to_many :networks, Network, join_through: "users_networks"

    timestamps()
  end

  @doc """
    Update Changeset
    - For updating a user
    - Does not require a password
  """
  def update_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email], [:password])
    |> validate_required([:name, :email])
    |> put_pass_hash
  end

  @doc """
    Registration Changeset
    - Called for new user.
    - Requires a password.
  """
  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> put_pass_hash
  end

  defp put_pass_hash(changeset) do
    case (changeset) do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end

  end
end
