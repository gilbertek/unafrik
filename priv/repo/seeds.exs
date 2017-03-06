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
#
# mix phoenix.gen.model Account accounts \
  # organization_id:references:organizations \
  # user_id:references:users

# mix phoenix.gen.html Session sessions email:string password:string --no-model

# mix phoenix.gen.model Role roles name:string slug:string\
#   status:integer disabled_at:datetime

# mix phoenix.gen.model Request requests description:string \
#   type:integer status:integer start_at:datetime \
#   end_at:datetime notes:text total_hrs:integer
#

# mix phoenix.gen.model Organization organizations \
#   name:string active:boolean description:string slug:string \
#   website:string status:integer last_active_at:datetime

# mix phoenix.gen.model Membership memberships \
#   organization_id:references:organizations \
#   user_id:references:users

# mix phoenix.gen.model Role roles name:string slug:string active:boolean

# mix phoenix.gen.model UserRole user_roles \
#   user_id:references:users \
#   role_id:references:roles


# def status_options do
#   DefaultStatusEnum.__enum_map__()
#   |> Enum.map(fn({k, _v}) -> {String.capitalize(Atom.to_string(k)), k} end)
# end

# https://gist.github.com/637e1a76f482620361d964784a58fa92

# mix phoenix.gen.html Message messages name:string \
# email:string company_name:string message_body:text \
# inquiry_type:integer

alias Unafrik.Repo
alias Unafrik.{Organization, User, Account, Registration}

org_changeset = Organization.changeset(%Organization{}, %{name: "Unafrik"})
{:ok, org} = Repo.insert(org_changeset)

user_changeset = User.changeset(%User{}, %{
  first_name: "John",
  last_name: "Doe",
  email: "admin@recessiv.com",
  organization_name: "Nolo",
  phone_number: "212 770-7777",
  password: Comeonin.Bcrypt.hashpwsalt("admin"),
  is_admin: true,
})
{:ok, user} = Repo.insert(user_changeset)

membership_changeset = Membership.changeset(%Membership{}, %{organization_id: org.id, user_id: user.id})
Repo.insert(membership_changeset)

params = %{
  first_name: "John",
  last_name: "Doe",
  email: "member@recessiv.com",
  organization_name: "Nolo Group",
  phone_number: "212 770-7777",
  password: "admin",
  is_admin: true,
}

changeset = Registration.changeset(%Registration{}, params)
Repo.transaction(Registration.to_multi(changeset))


request_params = %{
  description: "Time Off Request",
  type: 0,
  status: "pending"
  start_at: %{day: 17, hour: 9, min: 0, month: 4, sec: 0, year: 2017},
  end_at: %{day: 17, hour: 17, min: 0, month: 4, sec: 0, year: 2017}
  total_hrs: 8
}

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

def full_name(user) do
  "#{user.first_name} #{user.last_name}"
end
