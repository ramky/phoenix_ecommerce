Application.ensure_all_started(:hound)
ExUnit.start

Mix.Task.run "ecto.create", ~w(-r PhoenixEcommerce.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r PhoenixEcommerce.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(PhoenixEcommerce.Repo)

