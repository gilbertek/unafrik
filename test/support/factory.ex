defmodule Factory do
  use ExMachina.Ecto, repo: Unafrik.Repo

  def user_factory do
    %Unafrik.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      first_name: "Jane",
      last_name: "Doe",
      password: "password"
    }
  end

  def organization_factory do
    %Unafrik.Organization{
      name: sequence("Fake Organization")
    }
  end

  def account_factory do
    %Unafrik.Account{
      organization: build(:organization),
      user: build(:user)
    }
  end

  def department_factory do
  %Unafrik.Department{
    name: sequence("Department"),
    organization: build(:organization)
  }
  end

  def role_factory do
  %Unafrik.Role{
    name: sequence("role")
  }
  end

  def department_user_factory do
    %DepartmentUser{
      user: build(:user),
      department: build(:department),
      role_id: build(:role)
    }
  end

  def user_role_factory do
  %UserRole{
    user: build(:user),
    role: build(:role)
  }
  end
end
