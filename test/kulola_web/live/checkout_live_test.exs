defmodule KulolaWeb.CheckoutLiveTest do
  use KulolaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Kulola.Orders

  @cart_item %{
    "id" => "101",
    "name" => "Black Striped Pants",
    "size" => "10",
    "color" => "Black",
    "price" => 3_500,
    "quantity" => 1
  }

  test "offers distinct Nairobi fitting and delivery paths", %{conn: conn} do
    {:ok, view, html} = live(conn, ~p"/checkout")

    assert html =~ "Where are you located?"
    assert html =~ "Yes, I want to fit"
    assert html =~ "No, deliver it"
    assert html =~ "2-hour fitting window"

    html =
      view
      |> form("#checkout-form", %{"location_scope" => "nairobi", "order_type" => "delivery"})
      |> render_change()

    assert html =~ "Delivery details"
    assert html =~ "Apartment / office"
    assert html =~ "Courier / delivery service"
    refute html =~ "2-hour fitting window"
  end

  test "outside Nairobi uses delivery and shows the dispatch window", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/checkout")

    html =
      view
      |> form("#checkout-form", %{"location_scope" => "outside_nairobi"})
      |> render_change()

    assert html =~ "Countrywide delivery"
    assert html =~ "allow up to 48 hours for dispatch"
    assert html =~ "Delivery details"
    refute html =~ "Are you available for fitting?"
  end

  test "requires a custom area and requested additional-item details", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/checkout")
    render_hook(view, "cart_loaded", %{"items" => [@cart_item]})

    base = %{
      "name" => "Bridget",
      "email" => "bridget@example.com",
      "phone" => "0712345678",
      "location_scope" => "nairobi",
      "order_type" => "fitting",
      "delivery_area" => "Other",
      "address" => "Near the market",
      "fitting_date" => "2026-11-02",
      "fitting_time" => "2:00 PM – 4:00 PM",
      "wants_additional" => "no"
    }

    view |> form("#checkout-form", base) |> render_change()

    assert view |> form("#checkout-form") |> render_submit() =~
             "Please enter your delivery area."

    params = Map.merge(base, %{"other_area" => "Ruiru", "wants_additional" => "yes"})
    view |> form("#checkout-form", params) |> render_change()

    assert view |> form("#checkout-form") |> render_submit() =~
             "Please tell us which additional items to bring."
  end

  test "saves a fitting request and shows an on-site confirmation", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/checkout")
    render_hook(view, "cart_loaded", %{"items" => [@cart_item]})

    params = %{
      "name" => "Bridget",
      "email" => "bridget@example.com",
      "phone" => "0712345678",
      "location_scope" => "nairobi",
      "order_type" => "fitting",
      "delivery_area" => "Kilimani",
      "address" => "Yaya Centre",
      "fitting_date" => "2026-11-02",
      "fitting_time" => "2:00 PM – 4:00 PM",
      "wants_additional" => "yes",
      "additional_items" => "Brown sweater, size 10"
    }

    params_without_additional_items = Map.delete(params, "additional_items")
    view |> form("#checkout-form", params_without_additional_items) |> render_change()

    view
    |> form("#checkout-form", %{"additional_items" => params["additional_items"]})
    |> render_change()

    render_hook(view, "place_order", %{})

    order = Orders.list_orders() |> hd()
    assert order.status == "fitting_requested"
    assert order.order_type == "fitting"
    assert order.additional_items == "Brown sweater, size 10"
    assert_redirect(view, ~p"/success?reference=#{order.reference}")

    {:ok, success_view, _html} = live(conn, ~p"/success?reference=#{order.reference}")
    html = render(success_view)
    assert html =~ "Fitting Request Received!"
    assert html =~ "Brown sweater, size 10"
  end
end
