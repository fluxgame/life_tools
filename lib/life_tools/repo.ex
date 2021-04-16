defmodule LifeTools.Repo do
  use Ecto.Repo,
    otp_app: :life_tools,
    adapter: Ecto.Adapters.Postgres
end
