defmodule Fiddler.Network do
  use Fiddler.Web, :model
  alias Fiddler.User

  schema "networks" do
    field :name, :string
    field :discoverable, :boolean, default: false
    field :latitude, :float
    field :longitude, :float
    field :bssid, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    many_to_many :users, User, join_through: "users_networks"

    timestamps()
  end

  @doc """
    Update Network Changeset.
    - Does not require password.
  """
  def update_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :discoverable, :latitude, :longitude, :bssid], [:password])
    |> validate_required([:name, :discoverable, :latitude, :longitude, :bssid], [:password])
    |> put_hash_pass
  end

  @doc """
    Registration Network Changeset.
    - Requires password.
  """
  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :discoverable, :latitude, :longitude, :bssid, :password, :user_id])
    |> validate_required([:name, :discoverable, :latitude, :longitude, :bssid, :password, :user_id])
    |> put_hash_pass
  end

  defp put_hash_pass(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
