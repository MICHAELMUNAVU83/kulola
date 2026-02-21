defmodule KulolaWeb.TestimonialLive.Index do
  use KulolaWeb, :live_view

  alias Kulola.Testimonials
  alias Kulola.Testimonials.Testimonial

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :testimonials, Testimonials.list_testimonials())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Testimonial")
    |> assign(:testimonial, Testimonials.get_testimonial!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Testimonial")
    |> assign(:testimonial, %Testimonial{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Testimonials")
    |> assign(:testimonial, nil)
  end

  @impl true
  def handle_info({KulolaWeb.TestimonialLive.FormComponent, {:saved, testimonial}}, socket) do
    {:noreply, stream_insert(socket, :testimonials, testimonial)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    testimonial = Testimonials.get_testimonial!(id)
    {:ok, _} = Testimonials.delete_testimonial(testimonial)

    {:noreply, stream_delete(socket, :testimonials, testimonial)}
  end
end
