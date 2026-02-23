defmodule Kulola.OrderNotifier do
  import Swoosh.Email
  alias Kulola.Mailer

  def send_confirmation(%{email: email, name: name, reference: reference, items: items, total_amount: total} = _order) do
    items_html =
      items
      |> Enum.map(fn item ->
        """
        <tr>
          <td style="padding:10px 16px;border-bottom:1px solid #f0f0f0;">
            <div style="display:flex;gap:12px;align-items:center;">
              #{if item["image"], do: "<img src=\"#{item["image"]}\" width=\"56\" height=\"56\" style=\"border-radius:6px;object-fit:cover;\" />", else: ""}
              <div>
                <div style="font-weight:600;color:#111;">#{item["name"]}</div>
                #{if item["color"], do: "<div style=\"font-size:12px;color:#888;\">Colour: #{item["color"]}</div>", else: ""}
                #{if item["size"], do: "<div style=\"font-size:12px;color:#888;\">Size: #{item["size"]}</div>", else: ""}
                <div style="font-size:12px;color:#888;">Qty: #{item["quantity"]}</div>
              </div>
            </div>
          </td>
          <td style="padding:10px 16px;border-bottom:1px solid #f0f0f0;text-align:right;font-weight:600;color:#111;">
            KES #{KulolaWeb.Format.price((item["price"] || 0) * (item["quantity"] || 1))}
          </td>
        </tr>
        """
      end)
      |> Enum.join("")

    html_body = """
    <!DOCTYPE html>
    <html>
    <head><meta charset="UTF-8"></head>
    <body style="margin:0;padding:0;background:#f5f5f3;font-family:'Helvetica Neue',Arial,sans-serif;">
      <table width="100%" cellpadding="0" cellspacing="0" style="background:#f5f5f3;padding:40px 0;">
        <tr>
          <td align="center">
            <table width="600" cellpadding="0" cellspacing="0" style="background:#fff;border-radius:12px;overflow:hidden;box-shadow:0 2px 12px rgba(0,0,0,0.06);">

              <!-- Header -->
              <tr>
                <td style="background:#111;padding:32px 40px;text-align:center;">
                  <h1 style="margin:0;color:#fff;font-size:24px;font-weight:700;letter-spacing:2px;">KULOLA'S CLOSET</h1>
                  <p style="margin:8px 0 0;color:#aaa;font-size:13px;">Order Confirmation</p>
                </td>
              </tr>

              <!-- Greeting -->
              <tr>
                <td style="padding:32px 40px 16px;">
                  <h2 style="margin:0 0 8px;font-size:20px;color:#111;">Thank you, #{name}! 🎉</h2>
                  <p style="margin:0;color:#555;line-height:1.6;">
                    Your order has been received and payment confirmed. We'll get it packed and on its way to you shortly.
                  </p>
                </td>
              </tr>

              <!-- Order Reference -->
              <tr>
                <td style="padding:0 40px 24px;">
                  <div style="background:#f9f9f7;border-radius:8px;padding:16px 20px;display:inline-block;">
                    <span style="font-size:12px;color:#888;text-transform:uppercase;letter-spacing:1px;">Order Reference</span>
                    <div style="font-size:18px;font-weight:700;color:#111;margin-top:4px;">#{reference}</div>
                  </div>
                </td>
              </tr>

              <!-- Items -->
              <tr>
                <td style="padding:0 40px 8px;">
                  <h3 style="margin:0 0 12px;font-size:14px;text-transform:uppercase;letter-spacing:1px;color:#888;">Your Items</h3>
                  <table width="100%" cellpadding="0" cellspacing="0" style="border:1px solid #f0f0f0;border-radius:8px;overflow:hidden;">
                    #{items_html}
                  </table>
                </td>
              </tr>

              <!-- Total -->
              <tr>
                <td style="padding:16px 40px 32px;">
                  <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                      <td style="font-size:16px;font-weight:700;color:#111;">Total Paid</td>
                      <td style="text-align:right;font-size:18px;font-weight:700;color:#111;">KES #{KulolaWeb.Format.price(total)}</td>
                    </tr>
                  </table>
                </td>
              </tr>

              <!-- Footer -->
              <tr>
                <td style="background:#f9f9f7;padding:24px 40px;text-align:center;border-top:1px solid #eee;">
                  <p style="margin:0;font-size:13px;color:#888;">
                    Questions? Reply to this email or contact us at
                    <a href="mailto:hello@kulola.com" style="color:#111;">hello@kulola.com</a>
                  </p>
                  <p style="margin:12px 0 0;font-size:12px;color:#bbb;">© #{Date.utc_today().year} Kulola's Closet. All rights reserved.</p>
                </td>
              </tr>

            </table>
          </td>
        </tr>
      </table>
    </body>
    </html>
    """

    email =
      new()
      |> to({name, email})
      |> from({"Kulola's Closet", "orders@kulola.com"})
      |> subject("Order Confirmed — #{reference} 🛍️")
      |> html_body(html_body)

    Mailer.deliver(email)
  end
end
