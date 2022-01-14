defmodule TheScore.StatsTest do
  use TheScore.DataCase

  alias TheScore.Stats

  describe "rushings" do
    alias TheScore.Stats.Rushing

    import TheScore.StatsFixtures

    @invalid_attrs %{}

    test "list_rushings/0 returns all rushings" do
      rushing = rushing_fixture()
      assert Stats.list_rushings() == [rushing]
    end

    test "get_rushing!/1 returns the rushing with given id" do
      rushing = rushing_fixture()
      assert Stats.get_rushing!(rushing.id) == rushing
    end

    test "create_rushing/1 with valid data creates a rushing" do
      valid_attrs = %{}

      assert {:ok, %Rushing{} = rushing} = Stats.create_rushing(valid_attrs)
    end

    test "create_rushing/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_rushing(@invalid_attrs)
    end

    test "update_rushing/2 with valid data updates the rushing" do
      rushing = rushing_fixture()
      update_attrs = %{}

      assert {:ok, %Rushing{} = rushing} = Stats.update_rushing(rushing, update_attrs)
    end

    test "update_rushing/2 with invalid data returns error changeset" do
      rushing = rushing_fixture()
      assert {:error, %Ecto.Changeset{}} = Stats.update_rushing(rushing, @invalid_attrs)
      assert rushing == Stats.get_rushing!(rushing.id)
    end

    test "delete_rushing/1 deletes the rushing" do
      rushing = rushing_fixture()
      assert {:ok, %Rushing{}} = Stats.delete_rushing(rushing)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_rushing!(rushing.id) end
    end

    test "change_rushing/1 returns a rushing changeset" do
      rushing = rushing_fixture()
      assert %Ecto.Changeset{} = Stats.change_rushing(rushing)
    end
  end
end
