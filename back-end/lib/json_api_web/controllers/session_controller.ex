defmodule JsonApiWeb.SessionController do
  use JsonApiWeb, :controller

  alias JsonApi.Models
  alias JsonApi.Auth.Guardian

  def create(conn, params) do
    case authenticate(params) do
      {:ok, users} ->
        new_conn = Guardian.Plug.sign_in(conn, users)
        jwt = Guardian.Plug.current_token(new_conn)

        new_conn
        |> put_status(:created)
        |> render("show.json", users: users, jwt: jwt)

      :error ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json", error: "User or email invalid")
    end
  end

  def delete(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> put_status(:no_content)
    |> render("delete.json")
  end

  def refresh(conn, _params) do
    users = Guardian.Plug.current_resource(conn)
    jwt = Guardian.Plug.current_token(conn)

    case Guardian.refresh(jwt, ttl: {30, :days}) do
      {:ok, _, {new_jwt, _new_claims}} ->
        conn
        |> put_status(:ok)
        |> render("show.json", users: users, jwt: new_jwt)

      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json", error: "Not Authenticated")
    end
  end

  defp authenticate(%{"email" => email, "password" => password}) do
    Models.authenticate(email, password)
  end

  defp authenticate(_), do: :error
end
