defmodule Unafrik.Admin.PageControllerTest do
  use Unafrik.ConnCase

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, page_path(conn, :index)
    assert html_response(conn, 200) =~ "Admin Dashboard"
  end
end
