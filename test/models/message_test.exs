defmodule Unafrik.MessageTest do
  use Unafrik.ModelCase

  alias Unafrik.Message

  @valid_attrs %{company_name: "some content", email: "some content", inquiry_type: 42, message_body: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Message.changeset(%Message{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Message.changeset(%Message{}, @invalid_attrs)
    refute changeset.valid?
  end
end
