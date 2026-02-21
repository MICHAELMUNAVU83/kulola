defmodule Kulola.ProductImages.ProductImage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_images" do
    field :position, :string
    field :image, :string
    field :product_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product_image, attrs) do
    product_image
    |> cast(attrs, [:image, :position])
    |> validate_required([:image, :position])
  end
end
