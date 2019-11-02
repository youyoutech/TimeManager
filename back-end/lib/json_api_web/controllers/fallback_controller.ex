defmodule JsonApiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use JsonApiWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(JsonApiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(JsonApiWeb.ChangesetView)
    |> render("error.json", changeset: %Ecto.Changeset{})
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:not_found)
    |> put_view(JsonApiWeb.ChangesetView)
    |> render("error.json", changeset: %Ecto.Changeset{})
  end

  def call(conn, {:error, :bad_params}) do
    conn
    |> put_status(:not_found)
    |> put_view(JsonApiWeb.ChangesetView)
    |> render("error.json", changeset: %Ecto.Changeset{})
  end
end
