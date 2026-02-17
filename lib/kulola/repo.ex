defmodule Kulola.Repo do
  use Ecto.Repo,
    otp_app: :kulola,
    adapter: Ecto.Adapters.Postgres
end
