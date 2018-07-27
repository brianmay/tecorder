defmodule TecorderWeb.ChargeController do
  use TecorderWeb, :controller

  alias Tecorder.Log
  alias Tecorder.Log.Charge

  def index(conn, _params) do
    charges = Log.list_charges()

    render(conn, "index.html", charges: charges)
  end

  def new(conn, _params) do
    changeset = Log.change_charge(%Charge{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"charge" => charge_params}) do
    case Log.create_charge(charge_params) do
      {:ok, charge} ->
        conn
        |> put_flash(:info, "Charge created successfully.")
        |> redirect(to: charge_path(conn, :show, charge))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    charge = Log.get_charge!(id)

    render(conn, "show.html", charge: charge)
  end

  def edit(conn, %{"id" => id}) do
    charge = Log.get_charge!(id)

    changeset = Log.change_charge(charge)
    render(conn, "edit.html", charge: charge, changeset: changeset)
  end

  def update(conn, %{"id" => id, "charge" => charge_params}) do
    charge = Log.get_charge!(id)

    case Log.update_charge(charge, charge_params) do
      {:ok, charge} ->
        conn
        |> put_flash(:info, "Charge updated successfully.")
        |> redirect(to: charge_path(conn, :show, charge))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", charge: charge, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    charge = Log.get_charge!(id)
    {:ok, _charge} = Log.delete_charge(charge)

    conn
    |> put_flash(:info, "Charge deleted successfully.")
    |> redirect(to: charge_path(conn, :index))
  end
end
