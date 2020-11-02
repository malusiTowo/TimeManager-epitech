defmodule Api.ClocksTest do
  use Api.DataCase

  alias Api.Clocks

  describe "clocks" do
    alias Api.Clocks.Clock
    alias Api.Users
    alias Api.Users.User

    @valid_attrs %{status: true, time: ~N[2010-04-17 14:00:00]}
    @update_attrs %{status: false, time: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{status: nil, time: nil}

    def clock_fixture(attrs \\ %{}) do
      rand = Enum.random(1_000..9_999)
      emailGen = "some@email.com#{rand}"
      user_attrs =  %{email: emailGen, username: "some username", password: "Password1", role: "employee"}

      case Users.create_user(user_attrs) do
        {:ok, user} ->
          clock = Clocks.createClockForUser(user.id, @valid_attrs)
      end

      # {:ok, user} = Users.create_user(user_attrs)
      # Map.put(@valid_attrs, :user, user)

      # clock = Clocks.create_clock(%Clock{}, %{@valid_attrs | user: user.id})

      # {:ok, clock} =
      #   attrs
      #   |> Enum.into(%Clock{}, %{@valid_attrs | user: user.id})
      #   |> Clocks.create_clock()

      # clock
    end

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Clocks.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Clocks.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      clock = clock_fixture()
      assert clock.status == true
      assert clock.time == ~N[2010-04-17 14:00:00]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clocks.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{} = clock} = Clocks.update_clock(clock, @update_attrs)
      assert clock.status == false
      assert clock.time == ~N[2011-05-18 15:01:01]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Clocks.update_clock(clock, @invalid_attrs)
      assert clock == Clocks.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Clocks.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Clocks.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Clocks.change_clock(clock)
    end
  end
end
