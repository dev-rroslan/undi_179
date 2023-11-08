defmodule UndiWeb.LightLive do
  @moduledoc false
  use UndiWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok,
      assign(socket,
        brightness: 10
        )
    }
  end
  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <h1>Front Porch Light</h1>
    <div id="light">
      <div class="meter">
        <span style={"width:#{@brightness}%"}>
          <%= @brightness %>%
        </span>
      </div>
      <button phx-click="off">
      <img src={~p"/images/light-off.svg"} />
      </button>
      <button phx-click="down">
      <img src={~p"/images/down.svg"} />
      </button>
      <button phx-click="up">
      <img src={~p"/images/up.svg"} />
      </button>
      <button phx-click="on">
      <img src={~p"/images/light-on.svg"} />
      </button>
    </div>
    """
  end

  @impl Phoenix.LiveView
  def handle_event("up", _, socket) do
    {:noreply, update(socket, :brightness, &min(&1 + 10, 100))}
  end

  @impl Phoenix.LiveView
  def handle_event("down", _, socket) do
    {:noreply, update(socket, :brightness, &max(&1 - 10, 0))}
  end

  @impl Phoenix.LiveView
  def handle_event("off", _, socket) do
    {:noreply, assign(socket, :brightness, 0)}
  end

  @impl Phoenix.LiveView
  def handle_event("on", _, socket) do
    {:noreply, assign(socket, :brightness, 100)}
  end
end
