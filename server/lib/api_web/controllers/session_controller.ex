defmodule ApiWeb.SessionController do
  use ApiWeb, :controller

  alias Api.Users

  def sign_in(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Users.find_and_confirm_password(email, password) do
      {:ok, user} ->
         {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user, :api)

         conn
         |> render "sign_in.json", user: user, jwt: jwt
      {:error, _reason} ->
        conn
        |> put_status(401)
        |> render "error.json", message: "Could not login"
    end
  end
end