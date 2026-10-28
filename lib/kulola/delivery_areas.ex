defmodule Kulola.DeliveryAreas do
  import Ecto.Query
  alias Kulola.Repo
  alias Kulola.DeliveryAreas.DeliveryArea

  @defaults [
    {"CBD / City Centre", 250},
    {"Kilimani", 300},
    {"Kileleshwa", 300},
    {"Lavington", 350},
    {"Westlands", 350},
    {"Parklands", 350},
    {"South B / South C", 350},
    {"Lang'ata", 400},
    {"Karen", 500},
    {"Roysambu / Kasarani", 450},
    {"Embakasi", 500},
    {"Other", 0}
  ]

  def list(active_only \\ false) do
    query = from a in DeliveryArea, order_by: [asc: a.position, asc: a.name]
    query = if active_only, do: where(query, [a], a.active), else: query

    case Repo.all(query) do
      [] ->
        Enum.with_index(@defaults, fn {name, fee}, position ->
          %DeliveryArea{name: name, fee: fee, active: true, position: position}
        end)

      areas ->
        areas
    end
  end

  def get!(id), do: Repo.get!(DeliveryArea, id)
  def create(attrs), do: %DeliveryArea{} |> DeliveryArea.changeset(attrs) |> Repo.insert()
  def update(area, attrs), do: area |> DeliveryArea.changeset(attrs) |> Repo.update()
  def delete(area), do: Repo.delete(area)
end
