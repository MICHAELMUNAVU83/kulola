defmodule KulolaWeb.TestimonialLive.FormComponent do
  use KulolaWeb, :live_component

  alias Kulola.Testimonials

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage testimonial records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="testimonial-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:rating]} type="number" label="Rating" />
        <.input field={@form[:image]} type="text" label="Image" />
        <.input field={@form[:body]} type="text" label="Body" />
        <.input field={@form[:is_active]} type="checkbox" label="Is active" />
        <.input field={@form[:position]} type="number" label="Position" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Testimonial</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{testimonial: testimonial} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Testimonials.change_testimonial(testimonial))
     end)}
  end

  @impl true
  def handle_event("validate", %{"testimonial" => testimonial_params}, socket) do
    changeset = Testimonials.change_testimonial(socket.assigns.testimonial, testimonial_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"testimonial" => testimonial_params}, socket) do
    save_testimonial(socket, socket.assigns.action, testimonial_params)
  end

  defp save_testimonial(socket, :edit, testimonial_params) do
    case Testimonials.update_testimonial(socket.assigns.testimonial, testimonial_params) do
      {:ok, testimonial} ->
        notify_parent({:saved, testimonial})

        {:noreply,
         socket
         |> put_flash(:info, "Testimonial updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_testimonial(socket, :new, testimonial_params) do
    case Testimonials.create_testimonial(testimonial_params) do
      {:ok, testimonial} ->
        notify_parent({:saved, testimonial})

        {:noreply,
         socket
         |> put_flash(:info, "Testimonial created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
