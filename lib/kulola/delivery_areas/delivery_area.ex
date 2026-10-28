defmodule Kulola.DeliveryAreas.DeliveryArea do
  use Ecto.Schema
  import Ecto.Changeset

  schema "delivery_areas" do
    field :name, :string
    field :fee, :integer, default: 0
    field :active, :boolean, default: true
    field :position, :integer, default: 0
    timestamps(type: :utc_datetime)
  end

  def changeset(area, attrs) do
    area
    |> cast(attrs, [:name, :fee, :active, :position])
    |> validate_required([:name, :fee])
    |> validate_number(:fee, greater_than_or_equal_to: 0)
    |> unique_constraint(:name)
  end
end
