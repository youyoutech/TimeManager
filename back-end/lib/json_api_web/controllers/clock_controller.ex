defmodule JsonApiWeb.ClockController do
  use JsonApiWeb, :controller

  alias JsonApi.Models
  alias JsonApi.Models.Clock

  action_fallback(JsonApiWeb.FallbackController)

  def index(conn, _params) do
    clocks = Models.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def get_clocks_by_userid(conn, %{"id" => id}) do
    clocks = Models.get_clocks_by_user_id!(id)
    render(conn, "index.json", clocks: clocks)
  end

  def get_last_status(conn, %{"id" => id}) do
    clocks = Models.get_last_clock_status!(id)
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, params) do
    with {:ok, %Clock{} = clock} <- Models.create_clock(params) do
      conn
      |> put_status(:created)
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"id" => id}) do
    clock = Models.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id} = params) do
    clock = Models.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Models.update_clock(clock, params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Models.get_clock!(id)

    with {:ok, %Clock{}} <- Models.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
