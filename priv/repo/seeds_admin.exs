alias Kulola.Repo
alias Kulola.Accounts
alias Kulola.Accounts.User

admin_users = [
  %{
    name: "Michael Munavu",
    email: "michaelmunavu83@gmail.com",
    password: "123456",
    role: "super_admin"
  }
]

inserted =
  Enum.reduce(admin_users, 0, fn attrs, count ->
    case Repo.get_by(User, email: attrs.email) do
      nil ->
        case Accounts.invite_user(attrs) do
          {:ok, _user} ->
            IO.puts("  ✅  Created admin: #{attrs.email}")
            count + 1

          {:error, changeset} ->
            IO.puts("  ❌  Failed to create #{attrs.email}: #{inspect(changeset.errors)}")
            count
        end

      existing ->
        {:ok, _} = Accounts.admin_update_user(existing, Map.take(attrs, [:name, :role]))
        IO.puts("  ℹ️   Already exists (role updated): #{attrs.email}")
        count
    end
  end)

IO.puts("\n✅  Admin seed complete — #{inserted} new user(s) created.")
IO.puts("\n🔐  Default credentials:")
Enum.each(admin_users, fn u ->
  IO.puts("     Email:    #{u.email}")
  IO.puts("     Password: #{u.password}")
  IO.puts("     Role:     #{u.role}")
end)
IO.puts("\n⚠️   Change the password after your first login!\n")



# mix run priv/repo/seeds_admin.exs
