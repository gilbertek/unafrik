defmodule Unafrik.MessageControllerTest do
  use Unafrik.ConnCase

  alias Unafrik.Message
  @valid_attrs %{company_name: "some content", email: "some content", inquiry_type: 42, message_body: "some content", name: "some content"}
  @invalid_attrs %{}

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, message_path(conn, :new)
    assert html_response(conn, 200) =~ "New message"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, message_path(conn, :create), message: @valid_attrs
    assert redirected_to(conn) == message_path(conn, :index)
    assert Repo.get_by(Message, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, message_path(conn, :create), message: @invalid_attrs
    assert html_response(conn, 200) =~ "New message"
  end
end
