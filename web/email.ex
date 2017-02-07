defmodule Unafrik.Email do
  use Bamboo.Phoenix, view: Unafrik.EmailView

  def sign_in_email(user) do
    base_email()
    |> put_header("X-CMail-GroupName", "Sign In")
    |> to(user)
    |> subject("Your Sign In Link")
    |> assign(:user, user)
    |> render(:sign_in)
  end

  defp base_email do
    new_email()
    |> from("admin@unafrik.com")
    |> put_header("Reply-To", "admin@unafrik.com")
    |> put_html_layout({Unafrik.LayoutView, "email.html"})
  end
end

defimpl Bamboo.Formatter, for: Unafrik.User do
  def format_email_address(user, _opts) do
    {user.name, user.email}
  end
end
