defmodule Api.TeamContext.TeamUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "team_users" do
    field :user, :id
    field :team, :id

    timestamps()
  end

  @doc false
  def changeset(team_user, attrs) do
    team_user
    |> cast(attrs, [])
    |> validate_required([])
  end
end
