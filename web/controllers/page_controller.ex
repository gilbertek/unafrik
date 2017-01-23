defmodule Unafrik.PageController do
  use Unafrik.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
