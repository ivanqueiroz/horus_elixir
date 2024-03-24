defmodule HorusElixir.Transactions.Create do
  alias HorusElixir.Transactions.Transaction
  alias HorusElixir.Repo
  alias HorusElixir.ExchangeRatesApi.ExchangeRates
  alias HorusElixir.Converter.Calculator

  @spec call(:invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}) ::
          any()
  def call(params) do
    with {:ok, %{"rates" => rates} = _result} <- ExchangeRates.rates(params) do
      create_transaction(params, rates)
      |> Transaction.changeset()
      |> Repo.insert()
    end
  end

  defp create_transaction(params, rates) do
    amount = Decimal.new(params.amount)
    from_currency = Decimal.from_float(rates[params.from_currency])
    to_currency = Decimal.from_float(rates[params.to_currency])

    result =
      Calculator.convert_rate(
        amount,
        from_currency,
        to_currency
      )

    rate = Calculator.calc_rate(rates[params.from_currency], rates[params.to_currency])

    Map.new()
    |> Map.put(:result, result)
    |> Map.put(:currency_rate, rate)
    |> Map.put(:rate_from_currency, rates[params.from_currency])
    |> Map.put(:from_currency, params.from_currency)
    |> Map.put(:rate_to_currency, rates[params.to_currency])
    |> Map.put(:to_currency, params.to_currency)
    |> Map.put(:amount, amount)
    |> Map.put(:user_id, String.to_integer(params.user_id))
  end
end
