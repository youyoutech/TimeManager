defmodule JsonApi.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :json_api,
    module: JsonApi.Auth.Guardian,
    error_handler: JsonApi.Auth.ErrorHandler

  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
