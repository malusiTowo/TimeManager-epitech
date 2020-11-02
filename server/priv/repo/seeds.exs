# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Api.Repo.insert!(%Api.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias Api.Repo
alias Api.Users.User
alias Api.Users

user_params = %{
  username: "admin",
  email: "admin@email.com",
  password: "Password1",
}

update_params = %{
  role: "admin"
}
changeset = User.registration_changeset(%User{}, user_params)

 with {:ok, %User{} = user} <- Repo.insert(changeset) do
  Users.update_user(user, update_params)
end