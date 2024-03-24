defmodule HorusElixir.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transaction" do
    field :user_id, :integer
    field :from_currency, :string
    field :to_currency, :string
    field :amount, :decimal
    field :currency_rate, :decimal
    field :result, :decimal
    field :rate_from_currency, :decimal
    field :rate_to_currency, :decimal

    timestamps()
  end

  @spec changeset(
          :invalid
          | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, [
      :user_id,
      :from_currency,
      :to_currency,
      :amount,
      :currency_rate,
      :result,
      :rate_from_currency,
      :rate_to_currency
    ])
    |> validate_required([:user_id, :from_currency, :to_currency, :amount])
  end
end
