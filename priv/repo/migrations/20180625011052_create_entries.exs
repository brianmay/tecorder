defmodule Tecorder.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :date_time, :utc_datetime, null: false
      add :total_distance, :decimal, precision: 12, scale: 1, null: false
      add :distance, :decimal, precision: 12, scale: 1, null: false
      add :energy, :decimal, precision: 12, scale: 1, null: false
      add :battery_remaining, :integer, null: false
      add :temperature, :integer
      add :car_id, references(:cars, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:entries, [:car_id])
    create unique_index(:entries, [:car_id, :date_time])
  end
end
