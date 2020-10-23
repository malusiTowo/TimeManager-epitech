defmodule Api.WorkingTimesTest do
  use Api.DataCase

  alias Api.WorkingTimes

  describe "working_times" do
    alias Api.WorkingTimes.Workingtimes

    @valid_attrs %{end: ~N[2010-04-17 14:00:00], start: ~N[2010-04-17 14:00:00]}
    @update_attrs %{end: ~N[2011-05-18 15:01:01], start: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{end: nil, start: nil}

    def workingtimes_fixture(attrs \\ %{}) do
      {:ok, workingtimes} =
        attrs
        |> Enum.into(@valid_attrs)
        |> WorkingTimes.create_workingtimes()

      workingtimes
    end

    test "list_working_times/0 returns all working_times" do
      workingtimes = workingtimes_fixture()
      assert WorkingTimes.list_working_times() == [workingtimes]
    end

    test "get_workingtimes!/1 returns the workingtimes with given id" do
      workingtimes = workingtimes_fixture()
      assert WorkingTimes.get_workingtimes!(workingtimes.id) == workingtimes
    end

    test "create_workingtimes/1 with valid data creates a workingtimes" do
      assert {:ok, %Workingtimes{} = workingtimes} = WorkingTimes.create_workingtimes(@valid_attrs)
      assert workingtimes.end == ~N[2010-04-17 14:00:00]
      assert workingtimes.start == ~N[2010-04-17 14:00:00]
    end

    test "create_workingtimes/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WorkingTimes.create_workingtimes(@invalid_attrs)
    end

    test "update_workingtimes/2 with valid data updates the workingtimes" do
      workingtimes = workingtimes_fixture()
      assert {:ok, %Workingtimes{} = workingtimes} = WorkingTimes.update_workingtimes(workingtimes, @update_attrs)
      assert workingtimes.end == ~N[2011-05-18 15:01:01]
      assert workingtimes.start == ~N[2011-05-18 15:01:01]
    end

    test "update_workingtimes/2 with invalid data returns error changeset" do
      workingtimes = workingtimes_fixture()
      assert {:error, %Ecto.Changeset{}} = WorkingTimes.update_workingtimes(workingtimes, @invalid_attrs)
      assert workingtimes == WorkingTimes.get_workingtimes!(workingtimes.id)
    end

    test "delete_workingtimes/1 deletes the workingtimes" do
      workingtimes = workingtimes_fixture()
      assert {:ok, %Workingtimes{}} = WorkingTimes.delete_workingtimes(workingtimes)
      assert_raise Ecto.NoResultsError, fn -> WorkingTimes.get_workingtimes!(workingtimes.id) end
    end

    test "change_workingtimes/1 returns a workingtimes changeset" do
      workingtimes = workingtimes_fixture()
      assert %Ecto.Changeset{} = WorkingTimes.change_workingtimes(workingtimes)
    end
  end
end
