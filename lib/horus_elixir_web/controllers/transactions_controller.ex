defmodule HorusElixirWeb.TransactionsController do
  use HorusElixirWeb, :controller
  alias HorusElixirWeb.TransactionsController.CreateTransaction
  alias HorusElixirWeb.TransactionsController.GetTransactions
  alias HorusElixir.Transactions
  alias Transactions.Transaction

  action_fallback HorusElixirWeb.FallbackController

  def convert(conn, params) do
    with {:ok, valid_params} <- CreateTransaction.validate_params(params),
         {:ok, %Transaction{} = transaction} <- Transactions.create(valid_params) do
      conn
      |> put_status(:ok)
      |> render(:get, transaction: transaction)
    end
  end

  def show_by_user_id(conn, params) do
    with {:ok, %{:user_id => user_id}} <- GetTransactions.validate_params(params),
         {:ok, transactions} <- Transactions.get_by_user_id(user_id) do
      conn
      |> put_status(:ok)
      |> render(:transaction, transactions: transactions)
    end
  end
end
