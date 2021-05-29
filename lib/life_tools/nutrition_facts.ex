defmodule LifeTools.NutritionFacts do
  @moduledoc """
  The NutritionFacts context.
  """

  import Ecto.Query, warn: false
  alias LifeTools.Repo

  alias LifeTools.NutritionFacts.NutritionFact

  @doc """
  Returns the list of nutrition_facts.

  ## Examples

      iex> list_nutrition_facts()
      [%NutritionFact{}, ...]

  """
  def list_nutrition_facts do
    Repo.all(NutritionFact)
  end

  @doc """
  Gets a single nutrition_fact.

  Raises `Ecto.NoResultsError` if the Nutrition fact does not exist.

  ## Examples

      iex> get_nutrition_fact!(123)
      %NutritionFact{}

      iex> get_nutrition_fact!(456)
      ** (Ecto.NoResultsError)

  """
  def get_nutrition_fact!(id), do: Repo.get!(NutritionFact, id)

  @doc """
  Creates a nutrition_fact.

  ## Examples

      iex> create_nutrition_fact(%{field: value})
      {:ok, %NutritionFact{}}

      iex> create_nutrition_fact(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_nutrition_fact(attrs \\ %{}) do
    %NutritionFact{}
    |> NutritionFact.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a nutrition_fact.

  ## Examples

      iex> update_nutrition_fact(nutrition_fact, %{field: new_value})
      {:ok, %NutritionFact{}}

      iex> update_nutrition_fact(nutrition_fact, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_nutrition_fact(%NutritionFact{} = nutrition_fact, attrs) do
    nutrition_fact
    |> NutritionFact.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a nutrition_fact.

  ## Examples

      iex> delete_nutrition_fact(nutrition_fact)
      {:ok, %NutritionFact{}}

      iex> delete_nutrition_fact(nutrition_fact)
      {:error, %Ecto.Changeset{}}

  """
  def delete_nutrition_fact(%NutritionFact{} = nutrition_fact) do
    Repo.delete(nutrition_fact)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking nutrition_fact changes.

  ## Examples

      iex> change_nutrition_fact(nutrition_fact)
      %Ecto.Changeset{data: %NutritionFact{}}

  """
  def change_nutrition_fact(%NutritionFact{} = nutrition_fact, attrs \\ %{}) do
    NutritionFact.changeset(nutrition_fact, attrs)
  end
end
