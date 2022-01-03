defmodule PhxTodoWeb.PageController do
  use PhxTodoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
