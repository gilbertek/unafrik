defmodule Unafrik.RoleTest do
  use Unafrik.ModelCase

  alias Unafrik.Role

  @valid_attrs %{disabled_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, name: "some content", status: 0}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Role.changeset(%Role{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Role.changeset(%Role{}, @invalid_attrs)
    refute changeset.valid?
  end
end
