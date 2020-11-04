defmodule Api.TeamContext.TeamUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "team_users" do
    field :user, :id
    field :team, :id
    field :role, :string
    timestamps()
  end

  @doc false
  def changeset(team_user, attrs) do
    team_user
    |> cast(attrs, [:user, :team, :role])
    |> validate_required([:user, :team])
  end
end
