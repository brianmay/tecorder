defmodule TecorderWeb.EntryView do
  use TecorderWeb, :view

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

  defp to_enery_per_distance(nil, _), do: nil
  defp to_enery_per_distance(_, nil), do: nil
  defp to_enery_per_distance(_, %Decimal{coef: 0}), do: nil

  defp to_enery_per_distance(energy, distance) do
    Decimal.mult(energy, 1000)
    |> Decimal.div(distance)
    |> Decimal.round(1)
  end
end
