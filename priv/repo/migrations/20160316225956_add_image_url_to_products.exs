defmodule PhoenixEcommerce.Repo.Migrations.AddImageUrlToProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :image, :string
    end
  end
end
