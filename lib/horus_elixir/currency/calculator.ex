defmodule HorusElixir.Converter.Calculator do
  def convert_rate(amount, from_rate, to_rate) do
    amount
    |> Decimal.mult(to_rate)
    |> Decimal.div(from_rate)
  end

  @spec calc_rate(number(), number()) :: float()
  def calc_rate(from_rate, to_rate) do
    to_rate / from_rate
  end
end
