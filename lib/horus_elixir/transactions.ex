defmodule HorusElixir.Transactions do
  alias HorusElixir.Transactions.Create
  alias HorusElixir.Transactions.Get

  @spec create(
          :invalid
          | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: any()
  defdelegate create(params), to: Create, as: :call

  @spec get_by_user_id(integer()) :: {:ok, list()}
  defdelegate get_by_user_id(user_id), to: Get, as: :call
end
