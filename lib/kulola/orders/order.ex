defmodule Kulola.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :reference, :string
    field :email, :string
    field :name, :string
    field :phone, :string
    field :address, :string
    field :total_amount, :integer, default: 0
    field :status, :string, default: "pending"
    field :items, {:array, :map}, default: []
    field :promo_code, :string
    field :discount_amount, :integer, default: 0
    field :order_type, :string, default: "delivery"
    field :location_scope, :string, default: "nairobi"
    field :delivery_area, :string
    field :estate, :string
    field :building, :string
    field :unit_number, :string
    field :floor, :string
    field :delivery_instructions, :string
    field :delivery_fee, :integer, default: 0
    field :courier, :string
    field :fitting_date, :date
    field :fitting_time, :string
    field :additional_items, :string

    timestamps(type: :utc_datetime)
  end

  def changeset(order, attrs) do
    order
    |> cast(attrs, [
      :reference,
      :email,
      :name,
      :phone,
      :address,
      :total_amount,
      :status,
      :items,
      :promo_code,
      :discount_amount,
      :order_type,
      :location_scope,
      :delivery_area,
      :estate,
      :building,
      :unit_number,
      :floor,
      :delivery_instructions,
      :delivery_fee,
      :courier,
      :fitting_date,
      :fitting_time,
      :additional_items
    ])
    |> validate_required([:reference, :email, :name, :total_amount])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must be a valid email")
    |> validate_inclusion(:status, [
      "pending",
      "paid",
      "processing",
      "shipped",
      "delivered",
      "cancelled",
      "failed",
      "fitting_requested"
    ])
    |> validate_inclusion(:order_type, ["delivery", "fitting"])
    |> validate_inclusion(:location_scope, ["nairobi", "outside_nairobi"])
    |> validate_number(:delivery_fee, greater_than_or_equal_to: 0)
    |> unique_constraint(:reference)
  end
end
