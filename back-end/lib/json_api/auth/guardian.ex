defmodule JsonApi.Auth.Guardian do
  use Guardian, otp_app: :json_api

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    case JsonApi.Models.get_user(claims["sub"]) do
      nil -> {:error, "User not found"}
      users -> {:ok, users}
    end
  end

  def verify_claims(claims) do
    IO.inspect(claims)
  end
end
