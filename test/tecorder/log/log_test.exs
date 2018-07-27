defmodule Tecorder.LogTest do
  use Tecorder.DataCase

  alias Tecorder.Log

  describe "cars" do
    alias Tecorder.Log.Car

    @valid_attrs %{model: "some model", registration: "some registration"}
    @update_attrs %{model: "some updated model", registration: "some updated registration"}
    @invalid_attrs %{model: nil, registration: nil}

    def car_fixture(attrs \\ %{}) do
      {:ok, car} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Log.create_car()

      car
    end

    test "list_cars/0 returns all cars" do
      car = car_fixture()
      assert Log.list_cars() == [car]
    end

    test "get_car!/1 returns the car with given id" do
      car = car_fixture()
      assert Log.get_car!(car.id) == car
    end

    test "create_car/1 with valid data creates a car" do
      assert {:ok, %Car{} = car} = Log.create_car(@valid_attrs)
      assert car.model == "some model"
      assert car.registration == "some registration"
    end

    test "create_car/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Log.create_car(@invalid_attrs)
    end

    test "update_car/2 with valid data updates the car" do
      car = car_fixture()
      assert {:ok, car} = Log.update_car(car, @update_attrs)
      assert %Car{} = car
      assert car.model == "some updated model"
      assert car.registration == "some updated registration"
    end

    test "update_car/2 with invalid data returns error changeset" do
      car = car_fixture()
      assert {:error, %Ecto.Changeset{}} = Log.update_car(car, @invalid_attrs)
      assert car == Log.get_car!(car.id)
    end

    test "delete_car/1 deletes the car" do
      car = car_fixture()
      assert {:ok, %Car{}} = Log.delete_car(car)
      assert_raise Ecto.NoResultsError, fn -> Log.get_car!(car.id) end
    end

    test "change_car/1 returns a car changeset" do
      car = car_fixture()
      assert %Ecto.Changeset{} = Log.change_car(car)
    end
  end

  describe "entries" do
    alias Tecorder.Log.Entry

    @valid_attrs %{
      battery_remaining: 42,
      date_time: "2010-04-17 14:00:00.000000Z",
      distance: 42,
      energy: 42,
      temperature: 42
    }
    @update_attrs %{
      battery_remaining: 43,
      date_time: "2011-05-18 15:01:01.000000Z",
      distance: 43,
      energy: 43,
      temperature: 43
    }
    @invalid_attrs %{
      battery_remaining: nil,
      date_time: nil,
      distance: nil,
      energy: nil,
      temperature: nil
    }

    def entry_fixture(attrs \\ %{}) do
      {:ok, entry} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Log.create_entry()

      entry
    end

    test "list_entries/0 returns all entries" do
      entry = entry_fixture()
      assert Log.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Log.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      assert {:ok, %Entry{} = entry} = Log.create_entry(@valid_attrs)
      assert entry.battery_remaining == 42
      assert entry.date_time == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert entry.distance == 42
      assert entry.energy == 42
      assert entry.temperature == 42
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Log.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      assert {:ok, entry} = Log.update_entry(entry, @update_attrs)
      assert %Entry{} = entry
      assert entry.battery_remaining == 43
      assert entry.date_time == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert entry.distance == 43
      assert entry.energy == 43
      assert entry.temperature == 43
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Log.update_entry(entry, @invalid_attrs)
      assert entry == Log.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Log.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Log.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Log.change_entry(entry)
    end
  end

  describe "charges" do
    alias Tecorder.Log.Charge

    @valid_attrs %{
      start_date_time: "2010-04-17 14:00:00.000000Z",
      start_km: 42,
      stop_date_time: "2010-04-17 14:00:00.000000Z",
      stop_km: 42
    }
    @update_attrs %{
      start_date_time: "2011-05-18 15:01:01.000000Z",
      start_km: 43,
      stop_date_time: "2011-05-18 15:01:01.000000Z",
      stop_km: 43
    }
    @invalid_attrs %{start_date_time: nil, start_km: nil, stop_date_time: nil, stop_km: nil}

    def charge_fixture(attrs \\ %{}) do
      {:ok, charge} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Log.create_charge()

      charge
    end

    test "list_charges/0 returns all charges" do
      charge = charge_fixture()
      assert Log.list_charges() == [charge]
    end

    test "get_charge!/1 returns the charge with given id" do
      charge = charge_fixture()
      assert Log.get_charge!(charge.id) == charge
    end

    test "create_charge/1 with valid data creates a charge" do
      assert {:ok, %Charge{} = charge} = Log.create_charge(@valid_attrs)

      assert charge.start_date_time ==
               DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")

      assert charge.start_km == 42

      assert charge.stop_date_time ==
               DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")

      assert charge.stop_km == 42
    end

    test "create_charge/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Log.create_charge(@invalid_attrs)
    end

    test "update_charge/2 with valid data updates the charge" do
      charge = charge_fixture()
      assert {:ok, charge} = Log.update_charge(charge, @update_attrs)
      assert %Charge{} = charge

      assert charge.start_date_time ==
               DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")

      assert charge.start_km == 43

      assert charge.stop_date_time ==
               DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")

      assert charge.stop_km == 43
    end

    test "update_charge/2 with invalid data returns error changeset" do
      charge = charge_fixture()
      assert {:error, %Ecto.Changeset{}} = Log.update_charge(charge, @invalid_attrs)
      assert charge == Log.get_charge!(charge.id)
    end

    test "delete_charge/1 deletes the charge" do
      charge = charge_fixture()
      assert {:ok, %Charge{}} = Log.delete_charge(charge)
      assert_raise Ecto.NoResultsError, fn -> Log.get_charge!(charge.id) end
    end

    test "change_charge/1 returns a charge changeset" do
      charge = charge_fixture()
      assert %Ecto.Changeset{} = Log.change_charge(charge)
    end
  end
end
