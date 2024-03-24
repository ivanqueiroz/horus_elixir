defmodule HorusElixirWeb.TransactionsController.GetTransactions do
  use Ecto.Schema

  import Ecto.Changeset

  embedded_schema do
    field :user_id, :integer
  end

  def changeset(attrs) do
    %HorusElixirWeb.TransactionsController.GetTransactions{}
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
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
