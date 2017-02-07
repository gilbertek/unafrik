# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Unafrik.Repo.insert!(%Unafrik.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# mix phoenix.gen.html Subscription subscriptions \
#   name:string email:string source:string \
#   status:integer disabled_at:datetime

# mix phoenix.gen.html User users email:string password_hash:string \
#   status:integer name:string


# mix phoenix.gen.html Session sessions email:string password:string --no-model


user_params = %{name: "Simple User",
                 email: "user@test.com",
                 password: "supersecret"
               }

admin_params = %{name: "Admin User",
                 email: "admin@test.com",
                 password: "supersecret"
               }
unless Repo.get_by(User, email: admin_params[:email]) do
  %User{}
  |> User.registration_changeset(admin_params)
  |> Repo.insert!
end
