defmodule Kulola.Orders do
  import Ecto.Query

  alias Kulola.Repo
  alias Kulola.Orders.Order

  def create_order(attrs) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  def get_order_by_reference(reference) do
    Repo.get_by(Order, reference: reference)
  end

  def mark_paid(order) do
    order
    |> Order.changeset(%{status: "paid"})
    |> Repo.update()
  end

  def mark_failed(order) do
    order
    |> Order.changeset(%{status: "failed"})
    |> Repo.update()
  end

  def list_orders do
    Order
    |> order_by([o], desc: o.inserted_at)
    |> Repo.all()
  end

  def generate_reference do
    "KUL-#{:crypto.strong_rand_bytes(6) |> Base.encode16()}"
  end
end
