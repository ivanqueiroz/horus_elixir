defmodule HorusElixirWeb.TransactionsController.CreateTransaction do
  use Ecto.Schema

  alias HorusElixirWeb.TransactionsController.CreateTransaction
  import Ecto.Changeset

  embedded_schema do
    field :amount, :string
    field :to_currency, :string
    field :from_currency, :string
    field :user_id, :string
  end

  def changeset(attrs) do
    %CreateTransaction{}
    |> cast(attrs, [:amount, :to_currency, :from_currency, :user_id])
    |> validate_required([:amount, :to_currency, :from_currency, :user_id])
  end

  def validate_params(params) do
    case changeset(params) do
      %Ecto.Changeset{valid?: false} = changeset ->
        {:error, changeset}

      %Ecto.Changeset{valid?: true, changes: changes} ->
        {:ok, changes}
    end
  end
end
