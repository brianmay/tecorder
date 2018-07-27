defmodule Tecorder.Repo.Migrations.CreateCharges do
  use Ecto.Migration

  def change do
    create table(:charges) do
      add :start_date_time, :utc_datetime
      add :start_distance, :integer
      add :stop_date_time, :utc_datetime
      add :stop_distance, :integer
      add :current, :integer
      add :car_id, references(:cars, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:charges, [:car_id])
    create unique_index(:charges, [:car_id, :start_date_time])
    create unique_index(:charges, [:car_id, :stop_date_time])
  end
end
