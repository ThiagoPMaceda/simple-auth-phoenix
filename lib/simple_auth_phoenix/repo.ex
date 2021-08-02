defmodule SimpleAuthPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :simple_auth_phoenix,
    adapter: Ecto.Adapters.Postgres
end
