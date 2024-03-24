defmodule HorusElixirWeb.WelcomeController do
  use HorusElixirWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{message: "Welcom to Horus API"})
  end

end
