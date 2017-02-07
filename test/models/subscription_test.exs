defmodule Unafrik.SubscriptionTest do
  use Unafrik.ModelCase

  alias Unafrik.Subscription

  @valid_attrs %{email: "some content", name: "some content", source: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Subscription.changeset(%Subscription{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Subscription.changeset(%Subscription{}, @invalid_attrs)
    refute changeset.valid?
  end
end
