defmodule HorusElixir.ExchangeRatesApi.ExchangeRates do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "http://api.exchangeratesapi.io/v1"
  plug Tesla.Middleware.JSON

  def rates(
        %{from_currency: from_currency, to_currency: to_currency, amount: amount} =
          _params
      ) do
    cache_key =
      "api_cache:#{from_currency}?#{to_currency}?#{amount}"

    case Cachex.get(:api_cache, cache_key) do
      {:ok, nil} ->
        result =
          "/latest?access_key=#{api_key()}&symbols=#{api_rates()}&format=#{api_format()}"
          |> get()
          |> handle_response()

        Cachex.put(:api_cache, cache_key, result, ttl: :timer.minutes(60))
        result

      {:ok, result} ->
        result
    end
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_response({:ok, %Tesla.Env{status: 500}}) do
    {:error, :internal_server_error}
  end

  defp api_key do
    Application.fetch_env!(:horus_elixir, __MODULE__) |> Keyword.fetch!(:api_key)
  end

  defp api_format do
    Application.fetch_env!(:horus_elixir, __MODULE__) |> Keyword.fetch!(:api_format)
  end

  defp api_rates do
    Application.fetch_env!(:horus_elixir, __MODULE__) |> Keyword.fetch!(:api_rates)
  end
end
