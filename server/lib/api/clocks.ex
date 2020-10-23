defmodule Api.Clocks do
  @moduledoc """
  The Clocks context.
  """
  import Enum
  import Integer
  import Map
  import Ecto.Query, warn: false

  import Integer
  import Map
  import Ecto.Query, warn: false
  alias Api.Repo

  import Api.Users

  alias Api.Repo
  import Api.Users

  alias Api.Clocks.Clock

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clock{}, ...]

  """
  def list_clocks do
    Repo.all(Clock)
  end

  @doc """
  Gets a single clock.

  Raises `Ecto.NoResultsError` if the Clock does not exist.

  ## Examples

      iex> get_clock!(123)
      %Clock{}

      iex> get_clock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clock!(id), do: Repo.get!(Clock, id)

  @doc """
  Gets a single clock.

  Raises `Ecto.NoResultsError` if the Clock does not exist.

  ## Examples

      iex> get_clock!(123)
      %Clock{}

      iex> get_clock!(456)
      ** (Ecto.NoResultsError)

  """

  def getUserClocks(userId) do
    query = from(w in Clock, where: w.user == ^userId)
    Repo.all(query)
  end

  def getClocksForUser(userId) do
    query = from(w in Clock, where: w.user == ^userId)
    query |> last(:inserted_at) |> Repo.one

    # Repo.get_by(Clock, user: userId)
  end


  def key_to_atom(map) do
    Enum.reduce(map, %{}, fn
      {key, value}, acc when is_atom(key) -> Map.put(acc, key, value)
      # String.to_existing_atom saves us from overloading the VM by
      # creating too many atoms. It'll always succeed because all the fields
      # in the database already exist as atoms at runtime.
      {key, value}, acc when is_binary(key) -> Map.put(acc, String.to_existing_atom(key), value)
    end)
  end



  @doc """
  Creates a clock.

  ## Examples

      iex> create_clock(%{field: value})
      {:ok, %Clock{}}

      iex> create_clock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clock(attrs \\ %{}) do
    %Clock{}
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clock.

  ## Examples

      iex> update_clock(clock, %{field: new_value})
      {:ok, %Clock{}}

      iex> update_clock(clock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clock(%Clock{} = clock, attrs) do
    clock
    |> Clock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clock.

  ## Examples

      iex> delete_clock(clock)
      {:ok, %Clock{}}

      iex> delete_clock(clock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clock(%Clock{} = clock) do
    Repo.delete(clock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clock changes.

  ## Examples

      iex> change_clock(clock)
      %Ecto.Changeset{data: %Clock{}}

  """
  def change_clock(%Clock{} = clock, attrs \\ %{}) do
    Clock.changeset(clock, attrs)
  end

  # def handlePost(conn, %{"userID" => userId}) do
  #   clock = Accounts.get_clock_by_user(userId)
  #   if (clock == nil) do
  #     createClock(conn, userId)
  #   else
  #     newClock = %{"status": !clock.status, "time": DateTime.utc_now, "user": userId}
  #     with {:ok, %Clock{} = clock} <- Accounts.update_clock(clock, newClock) do
  #       render(conn, "show.json", clock: clock)
  #     end
  #   end
  # end

  def checkIfExists(user) do
    query = from p in Clock, where: p.user == ^user
    clockExists = Repo.exists?(query)
    # Repo.get_by!(Clock, user: user)
  end



  def createClockForUser(userId, clock) do

    user = Api.Users.get_user!(userId)

    newClock = %{user: userId}
    |> merge(clock)
    |> key_to_atom

    %Clock{}
    |> Ecto.Changeset.cast(newClock, [:time])
    |> Clock.changeset(newClock)
    |> Repo.insert!()

  end


  def clockUser(user) do
    {userId, ""}= parse(user)

    query = from p in Clock, where: p.user == ^user
    clockExists = Repo.exists?(query)

    user = Api.Users.get_user!(user)
    base = %{user: userId, time: DateTime.utc_now}

    if clockExists do
      clock = Repo.get_by!(Clock, user: userId)
      result = base |> merge(%{status: !clock.status})
      # clock
      # |> Clock.changeset(result)
      # |> Repo.update()
      update_clock(clock, result)

    else
      result = base |> merge(%{status: true })


      createClockForUser(userId, %{status: true, time: DateTime.utc_now})
      # %Clock{}
      # |> Ecto.Changeset.cast(result, [:time])
      # |> Clock.changeset(result)
      # |> Repo.insert!
    end
  end


end