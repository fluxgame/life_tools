defmodule LifeTools.FoodLogs.FoodLog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "food_logs" do
    field :consumed_at, :utc_datetime
    field :quantity, :float
    field :food_id, :id

    timestamps()
  end

  @doc false
  def changeset(food_log, attrs) do
    food_log
    |> cast(attrs, [:consumed_at, :quantity])
    |> validate_required([:consumed_at, :quantity])
  end
end
