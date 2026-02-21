defmodule KulolaWeb.BundleLive.FormComponent do
  use KulolaWeb, :live_component

  alias Kulola.Bundles

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage bundle records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="bundle-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:image]} type="text" label="Image" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Bundle</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{bundle: bundle} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Bundles.change_bundle(bundle))
     end)}
  end

  @impl true
  def handle_event("validate", %{"bundle" => bundle_params}, socket) do
    changeset = Bundles.change_bundle(socket.assigns.bundle, bundle_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"bundle" => bundle_params}, socket) do
    save_bundle(socket, socket.assigns.action, bundle_params)
  end

  defp save_bundle(socket, :edit, bundle_params) do
    case Bundles.update_bundle(socket.assigns.bundle, bundle_params) do
      {:ok, bundle} ->
        notify_parent({:saved, bundle})

        {:noreply,
         socket
         |> put_flash(:info, "Bundle updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_bundle(socket, :new, bundle_params) do
    case Bundles.create_bundle(bundle_params) do
      {:ok, bundle} ->
        notify_parent({:saved, bundle})

        {:noreply,
         socket
         |> put_flash(:info, "Bundle created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
