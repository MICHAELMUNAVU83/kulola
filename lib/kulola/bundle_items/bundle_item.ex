defmodule Kulola.BundleItems.BundleItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bundle_items" do

    field :bundle_id, :id
    field :product_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bundle_item, attrs) do
    bundle_item
    |> cast(attrs, [])
    |> validate_required([])
  end
end
