defmodule Tecorder.Log.Entry do
  use Ecto.Schema
  import Ecto.Changeset
  @timestamps_opts [type: :utc_datetime, usec: true]

  schema "entries" do
    field(:battery_remaining, :integer)
    field(:date_time, :utc_datetime)
    field(:total_distance, :decimal, precision: 12, scale: 2)
    field(:distance, :decimal, precision: 12, scale: 2)
    field(:energy, :decimal, precision: 12, scale: 2)
    field(:temperature, :integer)
    # field :car_id, :id
    belongs_to(:car, Tecorder.Log.Car)

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [
      :car_id,
      :date_time,
      :total_distance,
      :distance,
      :energy,
      :battery_remaining,
      :temperature
    ])
    |> validate_required([
      :car_id,
      :date_time,
      :total_distance,
      :distance,
      :energy,
      :battery_remaining
    ])
    |> foreign_key_constraint(:car_id)
    |> unique_constraint(:date_time, name: :entries_car_id_date_time_index)
  end
end
