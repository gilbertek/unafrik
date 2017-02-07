defmodule Unafrik.SessionControllerTest do
  use Unafrik.ConnCase

  alias Unafrik.Session
  @valid_attrs %{email: "some@content.com", password: "some content"}
  @invalid_attrs %{}

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, session_path(conn, :new)
    assert html_response(conn, 200) =~ "New session"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @valid_attrs
    assert redirected_to(conn) == session_path(conn, :index)
    assert Repo.get_by(Session, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @invalid_attrs
    assert html_response(conn, 200) =~ "New session"
  end

  test "deletes chosen resource", %{conn: conn} do
    session = Repo.insert! %Session{}
    conn = delete conn, session_path(conn, :delete, session)
    assert redirected_to(conn) == session_path(conn, :index)
    refute Repo.get(Session, session.id)
  end
end
