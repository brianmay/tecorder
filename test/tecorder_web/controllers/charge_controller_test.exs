defmodule TecorderWeb.ChargeControllerTest do
  use TecorderWeb.ConnCase

  alias Tecorder.Log

  @create_attrs %{
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

  def fixture(:charge) do
    {:ok, charge} = Log.create_charge(@create_attrs)
    charge
  end

  describe "index" do
    test "lists all charges", %{conn: conn} do
      conn = get(conn, charge_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Charges"
    end
  end

  describe "new charge" do
    test "renders form", %{conn: conn} do
      conn = get(conn, charge_path(conn, :new))
      assert html_response(conn, 200) =~ "New Charge"
    end
  end

  describe "create charge" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, charge_path(conn, :create), charge: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == charge_path(conn, :show, id)

      conn = get(conn, charge_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Charge"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, charge_path(conn, :create), charge: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Charge"
    end
  end

  describe "edit charge" do
    setup [:create_charge]

    test "renders form for editing chosen charge", %{conn: conn, charge: charge} do
      conn = get(conn, charge_path(conn, :edit, charge))
      assert html_response(conn, 200) =~ "Edit Charge"
    end
  end

  describe "update charge" do
    setup [:create_charge]

    test "redirects when data is valid", %{conn: conn, charge: charge} do
      conn = put(conn, charge_path(conn, :update, charge), charge: @update_attrs)
      assert redirected_to(conn) == charge_path(conn, :show, charge)

      conn = get(conn, charge_path(conn, :show, charge))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, charge: charge} do
      conn = put(conn, charge_path(conn, :update, charge), charge: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Charge"
    end
  end

  describe "delete charge" do
    setup [:create_charge]

    test "deletes chosen charge", %{conn: conn, charge: charge} do
      conn = delete(conn, charge_path(conn, :delete, charge))
      assert redirected_to(conn) == charge_path(conn, :index)

      assert_error_sent(404, fn ->
        get(conn, charge_path(conn, :show, charge))
      end)
    end
  end

  defp create_charge(_) do
    charge = fixture(:charge)
    {:ok, charge: charge}
  end
end
