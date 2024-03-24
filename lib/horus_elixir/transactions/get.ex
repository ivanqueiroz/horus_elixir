defmodule HorusElixir.Transactions.Get do
  alias HorusElixir.Repo
  alias HorusElixir.Transactions.Transaction
  import Ecto.Query

  @spec call(integer()) :: {:ok, [HorusElixir.Transactions.Transaction.t() | term()]}
  def call(user_id) do
    transactions =
      user_id
      |> get_transactions_by_user_id()
      |> Repo.all()

    {:ok, transactions}
  end

  @spec get_transactions_by_user_id(integer()) :: Ecto.Queryable.t()
  defp get_transactions_by_user_id(user_id) do
    from t in Transaction,
      where: t.user_id == ^user_id
  end
end
