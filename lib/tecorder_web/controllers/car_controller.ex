defmodule TecorderWeb.CarController do
  use TecorderWeb, :controller

  alias Tecorder.Log
  alias Tecorder.Log.Car

  def index(conn, _params) do
    cars = Log.list_cars()
    render(conn, "index.html", cars: cars)
  end

  def new(conn, _params) do
    changeset = Log.change_car(%Car{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"car" => car_params}) do
    case Log.create_car(car_params) do
      {:ok, car} ->
        conn
        |> put_flash(:info, "Car created successfully.")
        |> redirect(to: car_path(conn, :show, car))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    car = Log.get_car!(id)
    render(conn, "show.html", car: car)
  end

  def edit(conn, %{"id" => id}) do
    car = Log.get_car!(id)
    changeset = Log.change_car(car)
    render(conn, "edit.html", car: car, changeset: changeset)
  end

  def update(conn, %{"id" => id, "car" => car_params}) do
    car = Log.get_car!(id)

    case Log.update_car(car, car_params) do
      {:ok, car} ->
        conn
        |> put_flash(:info, "Car updated successfully.")
        |> redirect(to: car_path(conn, :show, car))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", car: car, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    car = Log.get_car!(id)
    {:ok, _car} = Log.delete_car(car)

    conn
    |> put_flash(:info, "Car deleted successfully.")
    |> redirect(to: car_path(conn, :index))
  end
end
