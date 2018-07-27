defmodule Tecorder.Log.Charge do
  use Ecto.Schema
  import Ecto.Changeset

  schema "charges" do
    field(:start_date_time, :utc_datetime)
    field(:start_distance, :integer)
    field(:stop_date_time, :utc_datetime)
    field(:stop_distance, :integer)
    field(:current, :integer)
    # field :car_id, :id
    belongs_to(:car, Tecorder.Log.Car)

    timestamps()
  end

  @doc false
  def changeset(charge, attrs) do
    charge
    |> cast(attrs, [
      :car_id,
      :start_date_time,
      :start_distance,
      :stop_date_time,
      :stop_distance,
      :current
    ])
    |> validate_required([
      :car_id,
      :start_date_time,
      :start_distance
    ])
    |> foreign_key_constraint(:car_id)
    |> unique_constraint(:start_date_time, name: :charges_car_id_start_date_time_index)
    |> unique_constraint(:stop_date_time, name: :charges_car_id_stop_date_time_index)
  end
end
