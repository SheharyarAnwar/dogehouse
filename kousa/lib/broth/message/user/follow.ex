defmodule Broth.Message.User.Follow do
  use Broth.Message.Cast

  @primary_key false
  embedded_schema do
    field(:id, :binary_id)
  end

  def changeset(initializer \\ %__MODULE__{}, data) do
    initializer
    |> cast(data, [:id])
    |> validate_required([:id])
  end

  def execute(changeset, state) do
    with {:ok, follow} <- apply_action(changeset, :validate) do
      Kousa.Follow.follow(state.user_id, follow.id, true)
      {:noreply, state}
    end
  end
end