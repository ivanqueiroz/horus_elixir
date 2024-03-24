defmodule HorusElixirWeb.TransactionsJSON do
  alias HorusElixir.Transactions.Transaction

  def get(%{transaction: transaction}) do
    %{
      data: data(transaction)
    }
  end

  def transaction(%{transactions: transactions}) do
    %{
      data: for(transaction <- transactions, do: data(transaction))
    }
  end

  defp data(%Transaction{} = transaction) do
    %{
      transactionId: transaction.id,
      userId: transaction.user_id,
      currencySource: transaction.from_currency,
      amount: transaction.amount,
      currencyDestiny: transaction.to_currency,
      result: transaction.result,
      currencyRate: transaction.currency_rate,
      date: transaction.inserted_at
    }
  end
end
