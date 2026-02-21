defmodule Kulola.BundleItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kulola.BundleItems` context.
  """

  @doc """
  Generate a bundle_item.
  """
  def bundle_item_fixture(attrs \\ %{}) do
    {:ok, bundle_item} =
      attrs
      |> Enum.into(%{

      })
      |> Kulola.BundleItems.create_bundle_item()

    bundle_item
  end
end
