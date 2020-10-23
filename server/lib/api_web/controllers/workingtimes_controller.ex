defmodule ApiWeb.WorkingtimesController do
  use ApiWeb, :controller

  alias Api.WorkingTimes
  alias Api.WorkingTimes.Workingtimes

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    working_times = WorkingTimes.list_working_times()
    render(conn, "index.json", working_times: working_times)
  end

  def create(conn, %{"workingtimes" => workingtimes_params}) do
    with {:ok, %Workingtimes{} = workingtimes} <- WorkingTimes.create_workingtimes(workingtimes_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtimes_path(conn, :show, workingtimes))
      |> render("show.json", workingtimes: workingtimes)
    end
  end

  # def show(conn,  %{"userId" => _userId}) do
  #   workingtimes = WorkingTimes.get_workingtimesByUserBetweenTimes!()
  #   render(conn, "show.json", working_times: workingtimes)
  # end

  def getWorkingTimes(conn,  %{"userId" => userId, "start"=> starttime, "end"=> endtime}) do
    working_times = WorkingTimes.get_workingtimesByUserBetweenTimes!(userId, starttime, endtime)
    render(conn, "index.json", working_times: working_times)
  end

  # def show(conn, %{"userId" => userId}) do
  #   workingtimes = WorkingTimes.get_workingtimes!(userId)
  #   render(conn, "show.json", workingtimes: workingtimes)
  # end

  def update(conn, %{"id" => id, "workingtimes" => workingtimes_params}) do
    workingtimes = WorkingTimes.get_workingtimes!(id)

    with {:ok, %Workingtimes{} = workingtimes} <- WorkingTimes.update_workingtimes(workingtimes, workingtimes_params) do
      render(conn, "show.json", workingtimes: workingtimes)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtimes = WorkingTimes.get_workingtimes!(id)

    with {:ok, %Workingtimes{}} <- WorkingTimes.delete_workingtimes(workingtimes) do
      send_resp(conn, :no_content, "")
    end
  end

  def getWorkingTimesByUserIdAndWorkingId(conn, %{"userId" => userId, "workingId" => workingId}) do
    #workingtimes = WorkingTimes.getWorkingTimesByUserIdAndWorkingId(userId)

    workingtimes = WorkingTimes.getWorkingTimesByUserIdAndWorkingId!(userId, workingId)
    render(conn, "show.json", workingtimes: workingtimes)
  end

  def createWorkingTimeForUser(conn, %{"userId"=> userId, "workingtime"=> workingtime}) do
    workingtime = WorkingTimes.createWorkingTimeForUser(userId,workingtime)
    render(conn, "show.json", workingtimes: workingtime)
  end

end
