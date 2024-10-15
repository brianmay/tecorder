defmodule Tecorder.Log.Car do
  use Ecto.Schema
  import Ecto.Changeset
  @timestamps_opts [type: :utc_datetime, usec: true]

  schema "cars" do
    field(:model, :string)
    field(:registration, :string)
    field(:battery_maximum, :integer)
    has_many(:entries, Tecorder.Log.Entry)
    has_many(:charges, Tecorder.Log.Charge)

    timestamps()
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:registration, :model, :battery_maximum])
    |> validate_required([:registration, :model, :battery_maximum])
    |> unique_constraint(:registration)
  end
end
