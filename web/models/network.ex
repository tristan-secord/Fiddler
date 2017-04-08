defmodule Fiddler.Network do
  use Fiddler.Web, :model
  alias Fiddler.User

  schema "networks" do
    field :name, :string
    field :discoverable, :boolean, default: true
    field :latitude, :float
    field :longitude, :float
    field :bssid, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :city, :string
    field :distance, :float, virtual: true

    many_to_many :users, User, join_through: "users_networks"

    timestamps()
  end

  @doc """
    Update Network Changeset.
    - Does not require password.
  """
  def update_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :discoverable, :latitude, :longitude, :bssid, :city], [:password])
    |> validate_required([:name, :discoverable, :latitude, :longitude, :bssid, :city], [:password])
    |> put_hash_pass
  end

  @doc """
    Registration Network Changeset.
    - Requires password.
  """
  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :discoverable, :latitude, :longitude, :bssid, :password, :city])
    |> validate_required([:name, :discoverable, :latitude, :longitude, :bssid, :password, :city])
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

  def with_user(query \\ __MODULE__) do
    query
    |> preload(:users)
  end

  def by_id(id, query) do
    query
    |> where(id: ^id)
  end

  def by_city(query, args)
  def by_city(query, %{city: city}) do
    query
    |> where(city: ^city)
  end
  def by_city(_query, _args), do: {:error, "Invalid Location"}

  def by_location(networks, args)
  def by_location([], _args), do: nil
  def by_location(networks, %{latitude: lat, longitude: lng}) when is_list(networks) do
    my_loc = [lat, lng]
    Enum.flat_map(networks, fn network ->
      dist = get_distance(my_loc, network)
      cond do
        dist <= 5 ->
          [
            network
            |> Map.put(:distance, dist)
          ]
        true ->
          []
      end
    end)
  end
  def by_location(_query, _args), do: nil

  def get_distance(my_loc, %{latitude: lat, longitude: lng}) do
    Geocalc.distance_between(my_loc, [lat, lng])
  end
end
