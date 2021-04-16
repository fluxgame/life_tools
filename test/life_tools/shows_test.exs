defmodule LifeTools.ShowsTest do
  use LifeTools.DataCase

  alias LifeTools.Shows

  describe "shows" do
    alias LifeTools.Shows.Show

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def show_fixture(attrs \\ %{}) do
      {:ok, show} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shows.create_show()

      show
    end

    test "list_shows/0 returns all shows" do
      show = show_fixture()
      assert Shows.list_shows() == [show]
    end

    test "get_show!/1 returns the show with given id" do
      show = show_fixture()
      assert Shows.get_show!(show.id) == show
    end

    test "create_show/1 with valid data creates a show" do
      assert {:ok, %Show{} = show} = Shows.create_show(@valid_attrs)
      assert show.title == "some title"
    end

    test "create_show/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shows.create_show(@invalid_attrs)
    end

    test "update_show/2 with valid data updates the show" do
      show = show_fixture()
      assert {:ok, %Show{} = show} = Shows.update_show(show, @update_attrs)
      assert show.title == "some updated title"
    end

    test "update_show/2 with invalid data returns error changeset" do
      show = show_fixture()
      assert {:error, %Ecto.Changeset{}} = Shows.update_show(show, @invalid_attrs)
      assert show == Shows.get_show!(show.id)
    end

    test "delete_show/1 deletes the show" do
      show = show_fixture()
      assert {:ok, %Show{}} = Shows.delete_show(show)
      assert_raise Ecto.NoResultsError, fn -> Shows.get_show!(show.id) end
    end

    test "change_show/1 returns a show changeset" do
      show = show_fixture()
      assert %Ecto.Changeset{} = Shows.change_show(show)
    end
  end
end
