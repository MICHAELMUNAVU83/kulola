defmodule Kulola.BundlesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kulola.Bundles` context.
  """

  @doc """
  Generate a bundle.
  """
  def bundle_fixture(attrs \\ %{}) do
    {:ok, bundle} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image: "some image",
        title: "some title"
      })
      |> Kulola.Bundles.create_bundle()

    bundle
  end
end
