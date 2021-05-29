defmodule LifeTools.FoodLogs do
  @moduledoc """
  The FoodLogs context.
  """

  import Ecto.Query, warn: false
  alias LifeTools.Repo

  alias LifeTools.FoodLogs.FoodLog

  @doc """
  Returns the list of food_logs.

  ## Examples

      iex> list_food_logs()
      [%FoodLog{}, ...]

  """
  def list_food_logs do
    Repo.all(FoodLog)
  end

  @doc """
  Gets a single food_log.

  Raises `Ecto.NoResultsError` if the Food log does not exist.

  ## Examples

      iex> get_food_log!(123)
      %FoodLog{}

      iex> get_food_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_food_log!(id), do: Repo.get!(FoodLog, id)

  @doc """
  Creates a food_log.

  ## Examples

      iex> create_food_log(%{field: value})
      {:ok, %FoodLog{}}

      iex> create_food_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_food_log(attrs \\ %{}) do
    %FoodLog{}
    |> FoodLog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a food_log.

  ## Examples

      iex> update_food_log(food_log, %{field: new_value})
      {:ok, %FoodLog{}}

      iex> update_food_log(food_log, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_food_log(%FoodLog{} = food_log, attrs) do
    food_log
    |> FoodLog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a food_log.

  ## Examples

      iex> delete_food_log(food_log)
      {:ok, %FoodLog{}}

      iex> delete_food_log(food_log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_food_log(%FoodLog{} = food_log) do
    Repo.delete(food_log)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking food_log changes.

  ## Examples

      iex> change_food_log(food_log)
      %Ecto.Changeset{data: %FoodLog{}}

  """
  def change_food_log(%FoodLog{} = food_log, attrs \\ %{}) do
    FoodLog.changeset(food_log, attrs)
  end
end
