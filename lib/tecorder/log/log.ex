defmodule Tecorder.Log do
  @moduledoc """
  The Log context.
  """

  import Ecto.Query, warn: false
  alias Tecorder.Repo

  alias Tecorder.Log.Car

  @doc """
  Returns the list of cars.

  ## Examples

      iex> list_cars()
      [%Car{}, ...]

  """
  def list_cars do
    Repo.all(Car)
  end

  @doc """
  Gets a single car.

  Raises `Ecto.NoResultsError` if the Car does not exist.

  ## Examples

      iex> get_car!(123)
      %Car{}

      iex> get_car!(456)
      ** (Ecto.NoResultsError)

  """
  def get_car!(id), do: Repo.get!(Car, id)

  @doc """
  Creates a car.

  ## Examples

      iex> create_car(%{field: value})
      {:ok, %Car{}}

      iex> create_car(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_car(attrs \\ %{}) do
    %Car{}
    |> Car.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a car.

  ## Examples

      iex> update_car(car, %{field: new_value})
      {:ok, %Car{}}

      iex> update_car(car, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_car(%Car{} = car, attrs) do
    car
    |> Car.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Car.

  ## Examples

      iex> delete_car(car)
      {:ok, %Car{}}

      iex> delete_car(car)
      {:error, %Ecto.Changeset{}}

  """
  def delete_car(%Car{} = car) do
    Repo.delete(car)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking car changes.

  ## Examples

      iex> change_car(car)
      %Ecto.Changeset{source: %Car{}}

  """
  def change_car(%Car{} = car) do
    Car.changeset(car, %{})
  end

  alias Tecorder.Log.Entry

  @doc """
  Returns the list of entries.

  ## Examples

      iex> list_entries()
      [%Entry{}, ...]

  """
  def list_entries do
    Repo.all(from p in Entry, preload: [:car])
  end

  @doc """
  Gets a single entry.

  Raises `Ecto.NoResultsError` if the Entry does not exist.

  ## Examples

      iex> get_entry!(123)
      %Entry{}

      iex> get_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entry!(id), do: Repo.get!(Entry, id) |> Repo.preload([:car])

  @doc """
  Gets previous entry.

  Raises `nil` if the Entry does not exist.

  ## Examples

      iex> get_prev_entry!(entry)
      %Entry{}

      iex> get_prev_entry!(entry)
      nil

  """

  def get_prev_entry!(date_time) do
    Repo.one(
      from(
        x in Entry,
        order_by: [desc: x.date_time],
        where: x.date_time < ^date_time,
        limit: 1
      )
    )
  end

  @doc """
  Creates a entry.

  ## Examples

      iex> create_entry(%{field: value})
      {:ok, %Entry{}}

      iex> create_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_entry(attrs \\ %{}) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a entry.

  ## Examples

      iex> update_entry(entry, %{field: new_value})
      {:ok, %Entry{}}

      iex> update_entry(entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_entry(%Entry{} = entry, attrs) do
    entry
    |> Entry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Entry.

  ## Examples

      iex> delete_entry(entry)
      {:ok, %Entry{}}

      iex> delete_entry(entry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_entry(%Entry{} = entry) do
    Repo.delete(entry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entry changes.

  ## Examples

      iex> change_entry(entry)
      %Ecto.Changeset{source: %Entry{}}

  """
  def change_entry(%Entry{} = entry) do
    Entry.changeset(entry, %{})
  end

  alias Tecorder.Log.Charge

  @doc """
  Returns the list of charges.

  ## Examples

      iex> list_charges()
      [%Charge{}, ...]

  """
  def list_charges do
    Repo.all(Charge)
  end

  @doc """
  Gets a single charge.

  Raises `Ecto.NoResultsError` if the Charge does not exist.

  ## Examples

      iex> get_charge!(123)
      %Charge{}

      iex> get_charge!(456)
      ** (Ecto.NoResultsError)

  """
  def get_charge!(id), do: Repo.get!(Charge, id)

  @doc """
  Creates a charge.

  ## Examples

      iex> create_charge(%{field: value})
      {:ok, %Charge{}}

      iex> create_charge(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_charge(attrs \\ %{}) do
    %Charge{}
    |> Charge.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a charge.

  ## Examples

      iex> update_charge(charge, %{field: new_value})
      {:ok, %Charge{}}

      iex> update_charge(charge, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_charge(%Charge{} = charge, attrs) do
    charge
    |> Charge.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Charge.

  ## Examples

      iex> delete_charge(charge)
      {:ok, %Charge{}}

      iex> delete_charge(charge)
      {:error, %Ecto.Changeset{}}

  """
  def delete_charge(%Charge{} = charge) do
    Repo.delete(charge)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking charge changes.

  ## Examples

      iex> change_charge(charge)
      %Ecto.Changeset{source: %Charge{}}

  """
  def change_charge(%Charge{} = charge) do
    Charge.changeset(charge, %{})
  end
end
