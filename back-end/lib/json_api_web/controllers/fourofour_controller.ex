defmodule JsonApiWeb.FourOFourController do
  use JsonApiWeb, :controller

  action_fallback(JsonApiWeb.FallbackController)

  def index(conn, _params) do
    render(conn, "404.json", _params)
    |> put_status(:not_found)
  end
end
