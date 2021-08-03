defmodule SimpleAuthPhoenix.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [
    :username,
    :password
  ]

  @fields [
    :username,
    :password,
    :role
  ]

  @shouldnt_edit [
    :id,
    :username,
    :password,
    :password_hash,
    :role
  ]

  @derive {Jason.Encoder, only: [:id | @required_params]}

  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string
    field :role, Ecto.Enum, values: [:admin, :editor, :normal]
    field :username, :string

    timestamps()
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@required_params)
    |> validate_length(:name, min: 3)
    |> validate_length(:password, min: 8)
    |> validate_format(:password, ~r/[0-9]+/, message: "Password must contain a number")
    |> validate_format(:password, ~r/[A-Z]+/,
      message: "Password must contain an upper-case letter"
    )
    |> validate_format(:password, ~r/[a-z]+/, message: "Password must contain a lower-case letter")
    |> validate_format(:password, ~r/[^\w0-9]+/i, message: "Password must contain a symbol")
    |> unique_constraint(:username)
    |> create_password_hash()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields -- @shouldnt_edit)
    |> validate_required(@required_params -- [:password])
    |> validate_length(:name, min: 3)
    |> validate_length(:password, min: 8)
    |> validate_format(:password, ~r/[0-9]+/, message: "Password must contain a number")
    |> validate_format(:password, ~r/[A-Z]+/,
      message: "Password must contain an upper-case letter"
    )
    |> validate_format(:password, ~r/[a-z]+/, message: "Password must contain a lower-case letter")
    |> validate_format(:password, ~r/[^\w0-9]+/i, message: "Password must contain a symbol")
    |> unique_constraint(:username)
    |> create_password_hash()
  end

  defp create_password_hash(
         changeset = %Ecto.Changeset{valid?: true, changes: %{password: password}}
       ) do
    change(changeset, Argon2.add_hash(password))
  end

  defp create_password_hash(changeset), do: changeset
end
