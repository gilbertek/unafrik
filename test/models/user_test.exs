defmodule Unafrik.UserTest do
  use Unafrik.ModelCase

  alias Unafrik.User

  @valid_attrs %{email: "some content", name: "some content", password_hash: "some content", status: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
