defmodule Tecorder.Log.CSV do
  @spec parse_datetime(String.t(), String.t()) :: DateTime.t()
  defp parse_datetime(date, time) when date != "" and time != "" do
    datetime = date <> "T" <> time <> ":00"
    {:ok, datetime, nil} = Calendar.NaiveDateTime.Parse.iso8601(datetime)
    {:ok, datetime} = Calendar.DateTime.from_naive(datetime, "Australia/Melbourne")
    datetime
  end

  defp to_integer(string) do
    String.to_integer(string)
  end

  defp to_float(string) do
    {float, ""} = Float.parse(string)
    float
  end

  defp record_to_data({:ok, record}) do
    start_date_time = parse_datetime(record["date"], record["charge start time"])

    entry = %{
      battery_remaining: to_integer(record["charge start km"]),
      date_time: start_date_time,
      total_distance: record["total km"],
      distance: record["km driven"],
      energy: record["energy"],
      car_id: 5
    }

    stop_date_time =
      if record["charge end time"] != "" do
        parse_datetime(record["date"], record["charge end time"])
      end

    stop_date_time =
      cond do
        stop_date_time == nil ->
          stop_date_time

        Calendar.DateTime.before?(start_date_time, stop_date_time) ->
          stop_date_time

        true ->
          dt = Calendar.DateTime.shift_zone!(stop_date_time, "Australia/Melbourne")
          {date, time} = Calendar.DateTime.to_date_and_time(dt)
          date = Calendar.Date.add!(date, 1)
          dt = Calendar.DateTime.from_date_and_time_and_zone!(date, time, "Australia/Melbourne")
          true = Calendar.DateTime.before?(start_date_time, dt)
          dt
      end

    stop_distance =
      if record["charge end km"] != "" do
        to_integer(record["charge end km"])
      end

    current =
      if record["charge current"] != "" do
        to_integer(record["charge current"])
      end

    charge = %{
      start_date_time: start_date_time,
      start_distance: to_integer(record["charge start km"]),
      stop_date_time: stop_date_time,
      stop_distance: stop_distance,
      current: current,
      car_id: 5
    }

    {entry, charge}
  end

  defp insert({entry, charge}) do
    case Tecorder.Log.create_entry(entry) do
      {:ok, _} -> :ok
      {:error, %Ecto.Changeset{errors: [date_time: {"has already been taken", _}]}} -> :ok
    end

    case Tecorder.Log.create_charge(charge) do
      {:ok, _} -> :ok
      {:error, %Ecto.Changeset{errors: [start_date_time: {"has already been taken", _}]}} -> :ok
      {:error, %Ecto.Changeset{errors: [stop_date_time: {"has already been taken", _}]}} -> :ok
    end

    :ok
  end

  def import_usage(filename) do
    filename
    |> File.stream!()
    |> CSV.decode(headers: true)
    |> Enum.map(&record_to_data/1)
    |> Enum.map(&insert/1)
    |> Enum.take(2)
  end
end
