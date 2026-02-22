defmodule KulolaWeb.Format do
  @moduledoc "Shared formatting helpers for templates."

  @doc "Formats an integer/float as a comma-separated string. e.g. 30800 → \"30,800\""
  def price(n) when is_nil(n), do: "0"

  def price(n) do
    n
    |> trunc()
    |> Integer.to_string()
    |> String.graphemes()
    |> Enum.reverse()
    |> Enum.chunk_every(3)
    |> Enum.join(",")
    |> String.graphemes()
    |> Enum.reverse()
    |> Enum.join()
  end
end
