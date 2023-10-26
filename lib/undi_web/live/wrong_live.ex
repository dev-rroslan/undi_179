defmodule UndiWeb.WrongLive do
  use UndiWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Make a guess:", answer: random_number())}
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <h1 class="mb-4 text-4xl font-extrabold">Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <br/>
    <h2>
      <%= for n <- 1..10 do %>
        <.link class="bg-blue-500 hover:bg-blue-700
        text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
        phx-click="guess" phx-value-number={n}>
          <%= n %>
        </.link>
      <% end %>
    </h2>
    """
  end

  defp random_number() do
    Enum.random(1..10)
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    {message, score, answer} =
    
    if String.to_integer(guess) == socket.assigns.answer do
      {
        "Your guess: #{guess}. You guess right! You won 5 points. New random number generated.",
        socket.assigns.score + 5,
        random_number()
      }
    else
      {
        "Your guess: #{guess}. You guessed wrong! Try again.",
        socket.assigns.score - 1,
        socket.assigns.answer
      }
    end
    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score,
        answer: answer
      )}
  end
      
end
