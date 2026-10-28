defmodule KulolaWeb.DeliveryAreaLive.Index do
  use KulolaWeb, :admin_live_view
  alias Kulola.DeliveryAreas

  def mount(_, _, socket),
    do:
      {:ok,
       socket
       |> assign(:page_title, "Delivery Areas")
       |> assign(:current_path, "/admin/delivery-areas")
       |> assign(:counts, %{pending_orders: Kulola.Orders.count_pending()})
       |> load()}

  def handle_event("save", %{"area" => params}, socket) do
    result =
      case params["id"] do
        "" -> DeliveryAreas.create(params)
        id -> DeliveryAreas.update(DeliveryAreas.get!(id), params)
      end

    case result do
      {:ok, _} -> {:noreply, socket |> put_flash(:info, "Delivery area saved.") |> load()}
      {:error, _} -> {:noreply, put_flash(socket, :error, "Check the area name and fee.")}
    end
  end

  def handle_event("toggle", %{"id" => id}, socket) do
    area = DeliveryAreas.get!(id)
    {:ok, _} = DeliveryAreas.update(area, %{active: !area.active})
    {:noreply, load(socket)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    {:ok, _} = DeliveryAreas.delete(DeliveryAreas.get!(id))
    {:noreply, load(socket)}
  end

  defp load(socket), do: assign(socket, :areas, DeliveryAreas.list())

  def render(assigns) do
    ~H"""
    <div class="space-y-6">
      <div class="rounded-3xl bg-gradient-to-r from-[#C8001F] to-[#8b0014] px-7 py-6 text-white">
        <p class="text-xs uppercase tracking-widest text-red-200">Fulfilment</p>
        <h1 class="font-serif text-2xl font-bold">Delivery areas & fees</h1>
        <p class="mt-1 text-sm text-red-100">Changes appear in checkout immediately.</p>
      </div>
      <form phx-submit="save" class="grid gap-3 rounded-2xl border bg-white p-5 sm:grid-cols-5">
        <input type="hidden" name="area[id]" value="" /><input
          name="area[name]"
          required
          placeholder="Area name"
          class="rounded-xl border-gray-300 sm:col-span-2"
        /><input
          name="area[fee]"
          type="number"
          min="0"
          required
          placeholder="Fee (KES)"
          class="rounded-xl border-gray-300"
        /><input
          name="area[position]"
          type="number"
          min="0"
          value="0"
          class="rounded-xl border-gray-300"
        /><button class="rounded-xl bg-[#C8001F] px-4 py-2 font-semibold text-white">Add area</button>
      </form>
      <div class="overflow-hidden rounded-2xl border bg-white">
        <table class="w-full text-sm">
          <thead class="bg-gray-50 text-left text-xs uppercase text-gray-400">
            <tr>
              <th class="p-4">Area</th>
              <th class="p-4">Fee</th>
              <th class="p-4">Position</th>
              <th class="p-4">Active</th>
              <th class="p-4 text-right">Actions</th>
            </tr>
          </thead>
          <tbody class="divide-y">
            <%= for area <- @areas do %>
              <tr>
                <td class="p-4 font-medium">{area.name}</td>
                <td class="p-4" colspan="2">
                  <%= if area.id do %>
                    <form phx-submit="save" class="flex items-center gap-2">
                      <input type="hidden" name="area[id]" value={area.id} />
                      <input type="hidden" name="area[name]" value={area.name} />
                      <input
                        name="area[fee]"
                        type="number"
                        min="0"
                        value={area.fee}
                        class="w-28 rounded-lg border-gray-300"
                      />
                      <input
                        name="area[position]"
                        type="number"
                        min="0"
                        value={area.position}
                        class="w-20 rounded-lg border-gray-300"
                      />
                      <button class="text-xs font-semibold text-[#C8001F]">Save</button>
                    </form>
                  <% else %>
                    KES {area.fee}
                  <% end %>
                </td>
                <td class="p-4">{if area.active, do: "Yes", else: "No"}</td>
                <td class="p-4 text-right">
                  <%= if area.id do %>
                    <button phx-click="toggle" phx-value-id={area.id} class="mr-3 text-[#C8001F]">
                      {if area.active, do: "Disable", else: "Enable"}
                    </button>
                    <button
                      phx-click="delete"
                      phx-value-id={area.id}
                      data-confirm="Delete this area?"
                      class="text-red-600"
                    >Delete</button>
                  <% end %>
                </td>
              </tr>
            <% end %>
          </tbody>
        </table>
      </div>
    </div>
    """
  end
end
