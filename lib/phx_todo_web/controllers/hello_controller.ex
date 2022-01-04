defmodule PhxTodoWeb.HelloController do
  use PhxTodoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"messenger" => messenger}) do
    require IEx
    IEx.pry()
    render(conn, "show.html", messenger: messenger)
  end
end
