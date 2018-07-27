defmodule TecorderWeb.EntryController do
  use TecorderWeb, :controller

  alias Tecorder.Log
  alias Tecorder.Log.Entry

  def parse_date_time(date, time) when date != "" and time != "" do
    datetime = date <> "T" <> time <> ":00"
    {:ok, datetime, nil} = Calendar.NaiveDateTime.Parse.iso8601(datetime)
    {:ok, datetime} = Calendar.DateTime.from_naive(datetime, "Australia/Melbourne")
    datetime
  end

  def index(conn, _params) do
    entries = Log.list_entries()

    render(conn, "index.html", entries: entries)
  end

  def new(conn, _params) do
    changeset = Log.change_entry(%Entry{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"entry" => entry_params}) do
    date_time = parse_date_time(entry_params["date"], entry_params["time"])
    prev_entry = Log.get_prev_entry!(date_time)
    total_distance = entry_params["total_distance"]

    distance =
      case prev_entry do
        nil -> total_distance
        _ -> total_distance - prev_entry.total_distance
      end

    entry_params = %{
      entry_params
      | date_time: date_time,
        total_distance: total_distance,
        distance: distance,
        energy: entry_params["energy"]
    }

    IO.inspect(entry_params)

    changeset = Log.change_entry(%Entry{})
    render(conn, "new.html", changeset: changeset)
    # case Log.create_entry(entry_params) do
    #   {:ok, entry} ->
    #     conn
    #     |> put_flash(:info, "Entry created successfully.")
    #     |> redirect(to: entry_path(conn, :show, entry))

    #   {:error, %Ecto.Changeset{} = changeset} ->
    #     render(conn, "new.html", changeset: changeset)
    # end
  end

  def show(conn, %{"id" => id}) do
    entry = Log.get_entry!(id)

    render(conn, "show.html", entry: entry)
  end

  def edit(conn, %{"id" => id}) do
    entry = Log.get_entry!(id)

    changeset = Log.change_entry(entry)
    render(conn, "edit.html", entry: entry, changeset: changeset)
  end

  def update(conn, %{"id" => id, "entry" => entry_params}) do
    entry = Log.get_entry!(id)

    date_time = parse_date_time(entry_params["date"], entry_params["time"])
    prev_entry = Log.get_prev_entry!(date_time)
    total_distance = entry_params["total_distance"]

    distance =
      case prev_entry do
        nil -> entry.distance
        _ -> Decimal.sub(total_distance, prev_entry.total_distance)
      end

    entry_params = %{
      date_time: date_time,
      total_distance: total_distance,
      distance: distance,
      energy: entry_params["energy"],
      temperature: entry_params["temperature"]
    }

    IO.inspect(entry_params)

    changeset = Log.change_entry(entry)

    case Log.update_entry(entry, entry_params) do
      {:ok, entry} ->
        IO.puts("successs")
        conn
        |> put_flash(:info, "Entry updated successfully.")
        |> redirect(to: entry_path(conn, :show, entry))

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.puts("error")
        IO.inspect(changeset)
        render(conn, "edit.html", entry: entry, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    entry = Log.get_entry!(id)
    {:ok, _entry} = Log.delete_entry(entry)

    conn
    |> put_flash(:info, "Entry deleted successfully.")
    |> redirect(to: entry_path(conn, :index))
  end
end
