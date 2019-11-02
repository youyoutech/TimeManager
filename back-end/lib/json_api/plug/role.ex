defmodule JsonApi.Plug.Role do
  use JsonApiWeb, :controller
  use Guardian, otp_app: :json_api
  alias JsonApi.Auth.Guardian
  alias JsonApi.Models
  import Plug.Conn

  def is_admin(conn, _params) do
    token = conn
      |> get_req_header("authorization")
      |> to_string
      |> String.slice(7..-1)
    claims = Guardian.decode_and_verify(token)
      |> elem(1)
    role = JsonApi.Models.get_user(claims["sub"]).role.name
      |> IO.inspect

    if role == "admin" do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> put_view(JsonApiWeb.ChangesetView)
      |> render("error.json", error: "You need to be admin to do this")
    end
  end

  def is_manager(conn, _params) do
    token = conn
      |> get_req_header("authorization")
      |> to_string
      |> String.slice(7..-1)
    claims = Guardian.decode_and_verify(token)
      |> elem(1)
    role = JsonApi.Models.get_user(claims["sub"]).role.name

    if role == "admin" || role == "manager" do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> put_view(JsonApiWeb.ChangesetView)
      |> render("error.json", error: "You need to be admin or to do this")
    end
  end

  defp remove_first_n_chars(s, n) do
    {_, new_string} = s |> String.codepoints() |> Enum.split(n)
    new_string |> Enum.join()
  end
end
