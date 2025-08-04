defmodule SuperdupernovaWeb.PageController do
  use SuperdupernovaWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
