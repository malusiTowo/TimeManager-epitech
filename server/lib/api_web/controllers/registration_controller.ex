defmodule ApiWeb.RegistrationController do
  use ApiWeb, :controller

  alias Api.Repo
  alias Api.Users.User

  def sign_up(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.user_path(conn, :show, user))
        |> render("success.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ApiWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end