defmodule LifeTools.Foods.Food do
  use Ecto.Schema
  import Ecto.Changeset

  schema "foods" do
    field :density, :float
    field :friendly_name, :string
    field :name, :string
    field :standard_unit_id, :id

    timestamps()
  end

  @doc false
  def changeset(food, attrs) do
    food
    |> cast(attrs, [:name, :friendly_name, :density])
    |> validate_required([:name, :friendly_name, :density])
  end
end
