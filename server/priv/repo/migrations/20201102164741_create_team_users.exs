defmodule Api.Repo.Migrations.CreateTeamUsers do
  use Ecto.Migration

  def change do
    create table(:team_users) do
      add :user, references(:users, on_delete: :nothing), null: false
      add :team, references(:teams, on_delete: :nothing), null: false
      add :role, :string, null: false
      timestamps()
    end

    create unique_index(:team_users, [:user, :team])
  end
end
