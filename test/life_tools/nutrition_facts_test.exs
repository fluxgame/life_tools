defmodule LifeTools.NutritionFactsTest do
  use LifeTools.DataCase

  alias LifeTools.NutritionFacts

  describe "nutrition_facts" do
    alias LifeTools.NutritionFacts.NutritionFact

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def nutrition_fact_fixture(attrs \\ %{}) do
      {:ok, nutrition_fact} =
        attrs
        |> Enum.into(@valid_attrs)
        |> NutritionFacts.create_nutrition_fact()

      nutrition_fact
    end

    test "list_nutrition_facts/0 returns all nutrition_facts" do
      nutrition_fact = nutrition_fact_fixture()
      assert NutritionFacts.list_nutrition_facts() == [nutrition_fact]
    end

    test "get_nutrition_fact!/1 returns the nutrition_fact with given id" do
      nutrition_fact = nutrition_fact_fixture()
      assert NutritionFacts.get_nutrition_fact!(nutrition_fact.id) == nutrition_fact
    end

    test "create_nutrition_fact/1 with valid data creates a nutrition_fact" do
      assert {:ok, %NutritionFact{} = nutrition_fact} = NutritionFacts.create_nutrition_fact(@valid_attrs)
      assert nutrition_fact.name == "some name"
    end

    test "create_nutrition_fact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = NutritionFacts.create_nutrition_fact(@invalid_attrs)
    end

    test "update_nutrition_fact/2 with valid data updates the nutrition_fact" do
      nutrition_fact = nutrition_fact_fixture()
      assert {:ok, %NutritionFact{} = nutrition_fact} = NutritionFacts.update_nutrition_fact(nutrition_fact, @update_attrs)
      assert nutrition_fact.name == "some updated name"
    end

    test "update_nutrition_fact/2 with invalid data returns error changeset" do
      nutrition_fact = nutrition_fact_fixture()
      assert {:error, %Ecto.Changeset{}} = NutritionFacts.update_nutrition_fact(nutrition_fact, @invalid_attrs)
      assert nutrition_fact == NutritionFacts.get_nutrition_fact!(nutrition_fact.id)
    end

    test "delete_nutrition_fact/1 deletes the nutrition_fact" do
      nutrition_fact = nutrition_fact_fixture()
      assert {:ok, %NutritionFact{}} = NutritionFacts.delete_nutrition_fact(nutrition_fact)
      assert_raise Ecto.NoResultsError, fn -> NutritionFacts.get_nutrition_fact!(nutrition_fact.id) end
    end

    test "change_nutrition_fact/1 returns a nutrition_fact changeset" do
      nutrition_fact = nutrition_fact_fixture()
      assert %Ecto.Changeset{} = NutritionFacts.change_nutrition_fact(nutrition_fact)
    end
  end
end
