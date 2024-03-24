defmodule HorusElixirWeb.FallbackController do
  use HorusElixirWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(HorusElixirWeb.ErrorJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: HorusElixirWeb.ErrorJSON)
    |> render(:error, status: :bad_request)
  end
end
