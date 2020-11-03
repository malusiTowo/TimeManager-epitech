defmodule ApiWeb.TeamUserController do
  use ApiWeb, :controller

  alias Api.TeamContext
  alias Api.TeamContext.TeamUser

  action_fallback ApiWeb.FallbackController

  def index(conn, %{"teamId" => teamId}) do
    team_users = TeamContext.list_team_users_by_team(teamId)
    render(conn, "index.json", team_users: team_users)
  end

  def index(conn, %{"userId" => userId}) do
    team_users = TeamContext.list_team_users_by_user(userId)
    render(conn, "index.json", team_users: team_users)
  end

  def index(conn, _params) do
    team_users = TeamContext.list_team_users()
    render(conn, "index.json", team_users: team_users)
  end

  def create(conn, %{"team_user" => team_user_params}) do
    with {:ok, %TeamUser{} = team_user} <- TeamContext.create_team_user(team_user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_user_path(conn, :show, team_user))
      |> render("show.json", team_user: team_user)
    end
  end

  def show(conn, %{"id" => id}) do
    team_user = TeamContext.get_team_user!(id)
    render(conn, "show.json", team_user: team_user)
  end

  def update(conn, %{"id" => id, "team_user" => team_user_params}) do
    team_user = TeamContext.get_team_user!(id)

    with {:ok, %TeamUser{} = team_user} <- TeamContext.update_team_user(team_user, team_user_params) do
      render(conn, "show.json", team_user: team_user)
    end
  end

  def delete(conn, %{"id" => id}) do
    team_user = TeamContext.get_team_user!(id)

    with {:ok, %TeamUser{}} <- TeamContext.delete_team_user(team_user) do
      send_resp(conn, :no_content, "")
    end
  end
end
