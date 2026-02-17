defmodule KulolaWeb.ErrorJSONTest do
  use KulolaWeb.ConnCase, async: true

  test "renders 404" do
    assert KulolaWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert KulolaWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
