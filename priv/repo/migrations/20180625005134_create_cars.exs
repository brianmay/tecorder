defmodule Tecorder.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table(:cars) do
      add :registration, :string, null: false
      add :battery_maximum, :integer, null: false
      add :model, :string, null: false

      timestamps()
    end

    create unique_index(:cars, [:registration])
  end
end
