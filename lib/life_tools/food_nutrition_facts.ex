defmodule LifeTools.FoodNutritionFacts do
  @moduledoc """
  The FoodNutritionFacts context.
  """

  import Ecto.Query, warn: false
  alias LifeTools.Repo

  alias LifeTools.FoodNutritionFacts.FoodNutritionFact

  @doc """
  Returns the list of food_nutrition_fact.

  ## Examples

      iex> list_food_nutrition_fact()
      [%FoodNutritionFact{}, ...]

  """
  def list_food_nutrition_fact do
    Repo.all(FoodNutritionFact)
  end

  @doc """
  Gets a single food_nutrition_fact.

  Raises `Ecto.NoResultsError` if the Food nutrition fact does not exist.

  ## Examples

      iex> get_food_nutrition_fact!(123)
      %FoodNutritionFact{}

      iex> get_food_nutrition_fact!(456)
      ** (Ecto.NoResultsError)

  """
  def get_food_nutrition_fact!(id), do: Repo.get!(FoodNutritionFact, id)

  @doc """
  Creates a food_nutrition_fact.

  ## Examples

      iex> create_food_nutrition_fact(%{field: value})
      {:ok, %FoodNutritionFact{}}

      iex> create_food_nutrition_fact(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_food_nutrition_fact(attrs \\ %{}) do
    %FoodNutritionFact{}
    |> FoodNutritionFact.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a food_nutrition_fact.

  ## Examples

      iex> update_food_nutrition_fact(food_nutrition_fact, %{field: new_value})
      {:ok, %FoodNutritionFact{}}

      iex> update_food_nutrition_fact(food_nutrition_fact, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_food_nutrition_fact(%FoodNutritionFact{} = food_nutrition_fact, attrs) do
    food_nutrition_fact
    |> FoodNutritionFact.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a food_nutrition_fact.

  ## Examples

      iex> delete_food_nutrition_fact(food_nutrition_fact)
      {:ok, %FoodNutritionFact{}}

      iex> delete_food_nutrition_fact(food_nutrition_fact)
      {:error, %Ecto.Changeset{}}

  """
  def delete_food_nutrition_fact(%FoodNutritionFact{} = food_nutrition_fact) do
    Repo.delete(food_nutrition_fact)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking food_nutrition_fact changes.

  ## Examples

      iex> change_food_nutrition_fact(food_nutrition_fact)
      %Ecto.Changeset{data: %FoodNutritionFact{}}

  """
  def change_food_nutrition_fact(%FoodNutritionFact{} = food_nutrition_fact, attrs \\ %{}) do
    FoodNutritionFact.changeset(food_nutrition_fact, attrs)
  end
end
