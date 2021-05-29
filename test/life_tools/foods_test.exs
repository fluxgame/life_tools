defmodule LifeTools.FoodsTest do
  use LifeTools.DataCase

  alias LifeTools.Foods

  describe "foods" do
    alias LifeTools.Foods.Food

    @valid_attrs %{density: 120.5, friendly_name: "some friendly_name", name: "some name"}
    @update_attrs %{density: 456.7, friendly_name: "some updated friendly_name", name: "some updated name"}
    @invalid_attrs %{density: nil, friendly_name: nil, name: nil}

    def food_fixture(attrs \\ %{}) do
      {:ok, food} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Foods.create_food()

      food
    end

    test "list_foods/0 returns all foods" do
      food = food_fixture()
      assert Foods.list_foods() == [food]
    end

    test "get_food!/1 returns the food with given id" do
      food = food_fixture()
      assert Foods.get_food!(food.id) == food
    end

    test "create_food/1 with valid data creates a food" do
      assert {:ok, %Food{} = food} = Foods.create_food(@valid_attrs)
      assert food.density == 120.5
      assert food.friendly_name == "some friendly_name"
      assert food.name == "some name"
    end

    test "create_food/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Foods.create_food(@invalid_attrs)
    end

    test "update_food/2 with valid data updates the food" do
      food = food_fixture()
      assert {:ok, %Food{} = food} = Foods.update_food(food, @update_attrs)
      assert food.density == 456.7
      assert food.friendly_name == "some updated friendly_name"
      assert food.name == "some updated name"
    end

    test "update_food/2 with invalid data returns error changeset" do
      food = food_fixture()
      assert {:error, %Ecto.Changeset{}} = Foods.update_food(food, @invalid_attrs)
      assert food == Foods.get_food!(food.id)
    end

    test "delete_food/1 deletes the food" do
      food = food_fixture()
      assert {:ok, %Food{}} = Foods.delete_food(food)
      assert_raise Ecto.NoResultsError, fn -> Foods.get_food!(food.id) end
    end

    test "change_food/1 returns a food changeset" do
      food = food_fixture()
      assert %Ecto.Changeset{} = Foods.change_food(food)
    end
  end
end
