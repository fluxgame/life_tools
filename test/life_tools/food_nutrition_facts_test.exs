defmodule LifeTools.FoodNutritionFactsTest do
  use LifeTools.DataCase

  alias LifeTools.FoodNutritionFacts

  describe "food_nutrition_fact" do
    alias LifeTools.FoodNutritionFacts.FoodNutritionFact

    @valid_attrs %{quantity: 120.5}
    @update_attrs %{quantity: 456.7}
    @invalid_attrs %{quantity: nil}

    def food_nutrition_fact_fixture(attrs \\ %{}) do
      {:ok, food_nutrition_fact} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FoodNutritionFacts.create_food_nutrition_fact()

      food_nutrition_fact
    end

    test "list_food_nutrition_fact/0 returns all food_nutrition_fact" do
      food_nutrition_fact = food_nutrition_fact_fixture()
      assert FoodNutritionFacts.list_food_nutrition_fact() == [food_nutrition_fact]
    end

    test "get_food_nutrition_fact!/1 returns the food_nutrition_fact with given id" do
      food_nutrition_fact = food_nutrition_fact_fixture()
      assert FoodNutritionFacts.get_food_nutrition_fact!(food_nutrition_fact.id) == food_nutrition_fact
    end

    test "create_food_nutrition_fact/1 with valid data creates a food_nutrition_fact" do
      assert {:ok, %FoodNutritionFact{} = food_nutrition_fact} = FoodNutritionFacts.create_food_nutrition_fact(@valid_attrs)
      assert food_nutrition_fact.quantity == 120.5
    end

    test "create_food_nutrition_fact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FoodNutritionFacts.create_food_nutrition_fact(@invalid_attrs)
    end

    test "update_food_nutrition_fact/2 with valid data updates the food_nutrition_fact" do
      food_nutrition_fact = food_nutrition_fact_fixture()
      assert {:ok, %FoodNutritionFact{} = food_nutrition_fact} = FoodNutritionFacts.update_food_nutrition_fact(food_nutrition_fact, @update_attrs)
      assert food_nutrition_fact.quantity == 456.7
    end

    test "update_food_nutrition_fact/2 with invalid data returns error changeset" do
      food_nutrition_fact = food_nutrition_fact_fixture()
      assert {:error, %Ecto.Changeset{}} = FoodNutritionFacts.update_food_nutrition_fact(food_nutrition_fact, @invalid_attrs)
      assert food_nutrition_fact == FoodNutritionFacts.get_food_nutrition_fact!(food_nutrition_fact.id)
    end

    test "delete_food_nutrition_fact/1 deletes the food_nutrition_fact" do
      food_nutrition_fact = food_nutrition_fact_fixture()
      assert {:ok, %FoodNutritionFact{}} = FoodNutritionFacts.delete_food_nutrition_fact(food_nutrition_fact)
      assert_raise Ecto.NoResultsError, fn -> FoodNutritionFacts.get_food_nutrition_fact!(food_nutrition_fact.id) end
    end

    test "change_food_nutrition_fact/1 returns a food_nutrition_fact changeset" do
      food_nutrition_fact = food_nutrition_fact_fixture()
      assert %Ecto.Changeset{} = FoodNutritionFacts.change_food_nutrition_fact(food_nutrition_fact)
    end
  end
end
