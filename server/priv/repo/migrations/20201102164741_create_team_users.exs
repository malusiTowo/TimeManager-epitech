defmodule Api.Repo.Migrations.CreateTeamUsers do
  use Ecto.Migration

  def change do
    create table(:team_users) do
      add :user, references(:users, on_delete: :nothing)
      add :team, references(:teams, on_delete: :nothing)

      timestamps()
    end

    create index(:team_users, [:user])
    create index(:team_users, [:team])
  end
end
