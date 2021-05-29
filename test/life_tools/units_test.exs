defmodule LifeTools.UnitsTest do
  use LifeTools.DataCase

  alias LifeTools.Units

  describe "units" do
    alias LifeTools.Units.Unit

    @valid_attrs %{abbreviation: "some abbreviation", liquid_or_solid: true, name: "some name", per_100: 120.5}
    @update_attrs %{abbreviation: "some updated abbreviation", liquid_or_solid: false, name: "some updated name", per_100: 456.7}
    @invalid_attrs %{abbreviation: nil, liquid_or_solid: nil, name: nil, per_100: nil}

    def unit_fixture(attrs \\ %{}) do
      {:ok, unit} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Units.create_unit()

      unit
    end

    test "list_units/0 returns all units" do
      unit = unit_fixture()
      assert Units.list_units() == [unit]
    end

    test "get_unit!/1 returns the unit with given id" do
      unit = unit_fixture()
      assert Units.get_unit!(unit.id) == unit
    end

    test "create_unit/1 with valid data creates a unit" do
      assert {:ok, %Unit{} = unit} = Units.create_unit(@valid_attrs)
      assert unit.abbreviation == "some abbreviation"
      assert unit.liquid_or_solid == true
      assert unit.name == "some name"
      assert unit.per_100 == 120.5
    end

    test "create_unit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Units.create_unit(@invalid_attrs)
    end

    test "update_unit/2 with valid data updates the unit" do
      unit = unit_fixture()
      assert {:ok, %Unit{} = unit} = Units.update_unit(unit, @update_attrs)
      assert unit.abbreviation == "some updated abbreviation"
      assert unit.liquid_or_solid == false
      assert unit.name == "some updated name"
      assert unit.per_100 == 456.7
    end

    test "update_unit/2 with invalid data returns error changeset" do
      unit = unit_fixture()
      assert {:error, %Ecto.Changeset{}} = Units.update_unit(unit, @invalid_attrs)
      assert unit == Units.get_unit!(unit.id)
    end

    test "delete_unit/1 deletes the unit" do
      unit = unit_fixture()
      assert {:ok, %Unit{}} = Units.delete_unit(unit)
      assert_raise Ecto.NoResultsError, fn -> Units.get_unit!(unit.id) end
    end

    test "change_unit/1 returns a unit changeset" do
      unit = unit_fixture()
      assert %Ecto.Changeset{} = Units.change_unit(unit)
    end
  end
end
