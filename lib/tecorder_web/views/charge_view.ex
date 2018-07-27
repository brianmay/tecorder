defmodule TecorderWeb.ChargeView do
  use TecorderWeb, :view

  defp formatted_seconds(seconds) do
    minutes = div(seconds, 60)
    hours = div(minutes, 60)

    "#{hours}:#{formatted_2digits(rem(minutes, 60))}"
  end

  defp formatted_2digits(s) when s < 10, do: "0#{s}"
  defp formatted_2digits(s), do: "#{s}"

  defp to_local_time(nil), do: nil

  defp to_local_time(date_time) do
    Calendar.DateTime.shift_zone!(date_time, "Australia/Melbourne")
  end

  defp to_time(nil), do: nil

  defp to_time(date_time) do
    {:ok, value} =
      date_time
      |> to_local_time
      |> Calendar.Strftime.strftime("%H:%M")

    value
  end

  defp to_date(nil), do: nil

  defp to_date(date_time) do
    {:ok, value} =
      date_time
      |> to_local_time
      |> Calendar.Strftime.strftime("%F")

    value
  end

  defp time_diff(nil, _date_time_2), do: nil
  defp time_diff(_date_time_1, nil), do: nil

  defp time_diff(date_time_1, date_time_2) do
    {:ok, seconds, _, _} = Calendar.DateTime.diff(date_time_1, date_time_2)
    formatted_seconds(seconds)
  end

  defp int_diff(nil, _date_time_2), do: nil
  defp int_diff(_date_time_1, nil), do: nil

  defp int_diff(int_1, int_2) do
    int_1 - int_2
  end

  defp charge_rate(%{start_distance: nil}) do
    nil
  end

  defp charge_rate(%{start_date_time: nil}) do
    nil
  end

  defp charge_rate(%{stop_distance: nil}) do
    nil
  end

  defp charge_rate(%{stop_date_time: nil}) do
    nil
  end

  defp charge_rate(charge) do
    d = charge.stop_distance - charge.start_distance
    {:ok, seconds, _, _} = Calendar.DateTime.diff(charge.stop_date_time, charge.start_date_time)

    case seconds do
      0 -> nil
      _ -> (d / (seconds / 3600)) |> Decimal.new() |> Decimal.round(1)
    end
  end
end
