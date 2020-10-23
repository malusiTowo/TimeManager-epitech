defmodule Api.WorkingTimes do
  @moduledoc """
  The WorkingTimes context.
  """
  import Integer
  import Map
  import Ecto.Query, warn: false
  alias Api.Repo

  import Api.Users
  alias Api.WorkingTimes.Workingtimes
  @doc """
  Returns the list of working_times.

  ## Examples

      iex> list_working_times()
      [%Workingtimes{}, ...]

  """
  def list_working_times do
    Repo.all(Workingtimes)
  end

  @doc """
  Gets a single workingtimes.

  Raises `Ecto.NoResultsError` if the Workingtimes does not exist.

  ## Examples

      iex> get_workingtimes!(123)
      %Workingtimes{}

      iex> get_workingtimes!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workingtimes!(id), do: Repo.get!(Workingtimes, id)

  def get_workingtimesByUserBetweenTimes!(userId, starttime, endtime) do
      query = from(w in Workingtimes, where: w.user == ^userId and w.start >= ^starttime and w.end <= ^endtime)
      Repo.all(query)
  end

  @doc """
  Creates a workingtimes.

  ## Examples

      iex> create_workingtimes(%{field: value})
      {:ok, %Workingtimes{}}

      iex> create_workingtimes(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workingtimes(attrs \\ %{}) do
    %Workingtimes{}
    |> Workingtimes.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a workingtimes.

  ## Examples

      iex> update_workingtimes(workingtimes, %{field: new_value})
      {:ok, %Workingtimes{}}

      iex> update_workingtimes(workingtimes, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workingtimes(%Workingtimes{} = workingtimes, attrs) do
    workingtimes
    |> Workingtimes.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a workingtimes.

  ## Examples

      iex> delete_workingtimes(workingtimes)
      {:ok, %Workingtimes{}}

      iex> delete_workingtimes(workingtimes)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workingtimes(%Workingtimes{} = workingtimes) do
    Repo.delete(workingtimes)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workingtimes changes.

  ## Examples

      iex> change_workingtimes(workingtimes)
      %Ecto.Changeset{data: %Workingtimes{}}

  """
  def change_workingtimes(%Workingtimes{} = workingtimes, attrs \\ %{}) do
    Workingtimes.changeset(workingtimes, attrs)
  end

  # def getWorkingTimesByUserIdAndWorkingId(id) do
  #   # WorkingTimes
  #   # |> where(user: ^userId)
  #   # |> and_where(id: ^id)
  #   # |> Repo.one
  #   # from(u in WorkingTimes, where: u.id == ^id or u.user == ^userId)
  #   # |> Repo.one
  #   Repo.get!(WorkingTimes, id)
  # end

  def getWorkingTimesByUserIdAndWorkingId!(userId, workingId), do: Repo.get_by!(Workingtimes, [user: userId, id: workingId])

  def key_to_atom(map) do
    Enum.reduce(map, %{}, fn
      {key, value}, acc when is_atom(key) -> Map.put(acc, key, value)
      # String.to_existing_atom saves us from overloading the VM by
      # creating too many atoms. It'll always succeed because all the fields
      # in the database already exist as atoms at runtime.
      {key, value}, acc when is_binary(key) -> Map.put(acc, String.to_existing_atom(key), value)
    end)
  end

  def createWorkingTimeForUser(userId, workingtime) do
    {user,""} =  parse(userId)
    user = Api.Users.get_user!(user)

    newWorkTime = %{user: userId}
    |> merge(workingtime)
    |> key_to_atom

    result = %Workingtimes{}
    |> Ecto.Changeset.cast(newWorkTime, [:start, :end])
    |> Workingtimes.changeset(newWorkTime)
    |> Repo.insert!()
  end
end
