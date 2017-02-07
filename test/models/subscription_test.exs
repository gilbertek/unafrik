defmodule Unafrik.SubscriptionTest do
  use Unafrik.ModelCase

  alias Unafrik.Subscription

  @valid_attrs %{disabled_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, email: "some@content.com", name: "some content", source: "some content", status: 1}
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
