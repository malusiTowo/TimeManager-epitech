defmodule ApiWeb.SessionView do
  use ApiWeb, :view

  def render("sign_in.json", %{user: user, jwt: jwt}) do
    %{
      status: :ok,
      data: %{
        token: jwt,
        email: user.email
      },
      message: "You are successfully logged in! Add this token to authorization header to make authorized requests."
    }
  end
  def render("error.json", %{message: message}) do
    %{
      status: :error,
      data: :null,
      message: message
    }
  end
end