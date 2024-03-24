defmodule HorusElixir.Repo.Migrations.AddTransactionsTable do
  use Ecto.Migration

  def change do
    create table("transaction") do
      add :user_id, :integer, null: false
      add :from_currency, :string, size: 5
      add :to_currency, :string, size: 5
      add :amount, :decimal
      add :currency_rate, :decimal
      add :result, :decimal
      add :rate_from_currency, :decimal
      add :rate_to_currency, :decimal

      timestamps()
    end
  end
end
