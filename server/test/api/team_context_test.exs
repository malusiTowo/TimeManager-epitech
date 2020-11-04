defmodule Api.TeamContextTest do
  use Api.DataCase

  alias Api.TeamContext

  describe "teams" do
    alias Api.TeamContext.Team

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def team_fixture(attrs \\ %{}) do
      {:ok, team} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TeamContext.create_team()

      team
    end

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert TeamContext.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert TeamContext.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      assert {:ok, %Team{} = team} = TeamContext.create_team(@valid_attrs)
      assert team.description == "some description"
      assert team.name == "some name"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TeamContext.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      assert {:ok, %Team{} = team} = TeamContext.update_team(team, @update_attrs)
      assert team.description == "some updated description"
      assert team.name == "some updated name"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = TeamContext.update_team(team, @invalid_attrs)
      assert team == TeamContext.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = TeamContext.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> TeamContext.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = TeamContext.change_team(team)
    end
  end

  describe "team_users" do
    alias Api.TeamContext.TeamUser
    alias Api.Users
    alias Api.Users.User

    @valid_attrs %{role: "some role"}
    @update_attrs %{role: "some new role"}
    @invalid_attrs %{role: nil, team: nil, user: nil}

    def team_user_fixture(attrs \\ %{}) do

      team_attrs =  %{name: "some name", description: "some desc"}

      rand = Enum.random(1_000..9_999)
      emailGen = "some@email.com#{rand}"
      user_attrs =  %{email: emailGen, username: "some username", password: "Password1", role: "employee"}


      user = Users.create_user(user_attrs)
      team = TeamContext.create_team(team_attrs)

      team_user = TeamContext.create_team_user(%{role: "some role", team: team.id, user: user.id})

      # case Users.create_user(user_attrs) do
      #   {:ok, user} ->
      #     case TeamContext.create_team(team_attrs) do
      #       {:ok, team} ->
      #         team_user = TeamContext.create_team_user(%{role: "some role", team: team.id, user: user.id})
      #     end
      # end

      # {:ok, team_user} =
      #   attrs
      #   |> Enum.into(@valid_attrs)
      #   |> TeamContext.create_team_user()
    end

    test "list_team_users/0 returns all team_users" do
      team_user = team_user_fixture()
      assert TeamContext.list_team_users() == [team_user]
    end

    test "get_team_user!/1 returns the team_user with given id" do
      team_user = team_user_fixture()
      assert TeamContext.get_team_user!(team_user.id) == team_user
    end

    test "create_team_user/1 with valid data creates a team_user" do
      team_user = team_user_fixture()
      assert team_user.role == "some role"
    end

    test "create_team_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TeamContext.create_team_user(@invalid_attrs)
    end

    test "update_team_user/2 with valid data updates the team_user" do
      team_user = team_user_fixture()
      assert {:ok, %TeamUser{} = team_user} = TeamContext.update_team_user(team_user, @update_attrs)
    end

    test "update_team_user/2 with invalid data returns error changeset" do
      team_user = team_user_fixture()
      assert {:error, %Ecto.Changeset{}} = TeamContext.update_team_user(team_user, @invalid_attrs)
      assert team_user == TeamContext.get_team_user!(team_user.id)
    end

    test "delete_team_user/1 deletes the team_user" do
      team_user = team_user_fixture()
      assert {:ok, %TeamUser{}} = TeamContext.delete_team_user(team_user)
      assert_raise Ecto.NoResultsError, fn -> TeamContext.get_team_user!(team_user.id) end
    end

    test "change_team_user/1 returns a team_user changeset" do
      team_user = team_user_fixture()
      assert %Ecto.Changeset{} = TeamContext.change_team_user(team_user)
    end
  end
end
