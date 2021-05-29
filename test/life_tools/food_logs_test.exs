defmodule LifeTools.FoodLogsTest do
  use LifeTools.DataCase

  alias LifeTools.FoodLogs

  describe "food_logs" do
    alias LifeTools.FoodLogs.FoodLog

    @valid_attrs %{consumed_at: "2010-04-17T14:00:00Z", quantity: 120.5}
    @update_attrs %{consumed_at: "2011-05-18T15:01:01Z", quantity: 456.7}
    @invalid_attrs %{consumed_at: nil, quantity: nil}

    def food_log_fixture(attrs \\ %{}) do
      {:ok, food_log} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FoodLogs.create_food_log()

      food_log
    end

    test "list_food_logs/0 returns all food_logs" do
      food_log = food_log_fixture()
      assert FoodLogs.list_food_logs() == [food_log]
    end

    test "get_food_log!/1 returns the food_log with given id" do
      food_log = food_log_fixture()
      assert FoodLogs.get_food_log!(food_log.id) == food_log
    end

    test "create_food_log/1 with valid data creates a food_log" do
      assert {:ok, %FoodLog{} = food_log} = FoodLogs.create_food_log(@valid_attrs)
      assert food_log.consumed_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert food_log.quantity == 120.5
    end

    test "create_food_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FoodLogs.create_food_log(@invalid_attrs)
    end

    test "update_food_log/2 with valid data updates the food_log" do
      food_log = food_log_fixture()
      assert {:ok, %FoodLog{} = food_log} = FoodLogs.update_food_log(food_log, @update_attrs)
      assert food_log.consumed_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert food_log.quantity == 456.7
    end

    test "update_food_log/2 with invalid data returns error changeset" do
      food_log = food_log_fixture()
      assert {:error, %Ecto.Changeset{}} = FoodLogs.update_food_log(food_log, @invalid_attrs)
      assert food_log == FoodLogs.get_food_log!(food_log.id)
    end

    test "delete_food_log/1 deletes the food_log" do
      food_log = food_log_fixture()
      assert {:ok, %FoodLog{}} = FoodLogs.delete_food_log(food_log)
      assert_raise Ecto.NoResultsError, fn -> FoodLogs.get_food_log!(food_log.id) end
    end

    test "change_food_log/1 returns a food_log changeset" do
      food_log = food_log_fixture()
      assert %Ecto.Changeset{} = FoodLogs.change_food_log(food_log)
    end
  end
end
