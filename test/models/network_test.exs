defmodule Fiddler.NetworkTest do
  use Fiddler.ModelCase

  alias Fiddler.Network

  @valid_attrs %{bssid: "some content", discoverable: true, latitude: "120.5", longitude: "120.5", name: "some content", password: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Network.changeset(%Network{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Network.changeset(%Network{}, @invalid_attrs)
    refute changeset.valid?
  end
end
