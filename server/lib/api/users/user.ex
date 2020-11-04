defmodule Api.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  # alias Comeonin.Bcrypt

  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :role, :string, default: "employee"

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :role ])
    |> validate_required([:username, :email])
    |> validate_changeset
  end

    def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :username, :password])
    |> validate_required([:email, :username, :password])
    |> validate_changeset
  end

  defp validate_changeset(struct) do
    struct
    |> validate_length(:email, min: 5, max: 255)
    |> validate_format(:email, ~r/^\S+@\S+\.\S+$/)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 8)
    |> validate_format(:role, ~r/(admin)\b|(manager)\b|(employee)\b/, [message: "Role must be admin or manager or employee"])
    |> validate_format(:password, ~r/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).*/, [message: "Must include at least one lowercase letter, one uppercase letter, and one digit"])
    |> generate_password_hash
  end

  defp generate_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash,  Bcrypt.hash_pwd_salt(password))
      _ ->
        changeset
    end
  end



end
