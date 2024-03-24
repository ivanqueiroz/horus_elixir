defmodule HorusElixir.Repo do
  use Ecto.Repo,
    otp_app: :horus_elixir,
    adapter: Ecto.Adapters.Postgres
end
