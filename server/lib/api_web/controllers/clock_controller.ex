defmodule ApiWeb.ClockController do
  use ApiWeb, :controller

  alias Api.Clocks
  alias Api.Clocks.Clock

  import Api.Users

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    clocks = Clocks.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def createClockForUser(conn, %{"userId"=> userId, "clock"=> clock}) do
    clock = Clocks.createClockForUser(userId, clock)
    render(conn, "show.json", clock: clock)
  end

  def show(conn, %{"id" => id}) do
    clock = Clocks.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Clocks.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Clocks.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Clocks.get_clock!(id)

    with {:ok, %Clock{}} <- Clocks.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end

  def getClocksForUser(conn, %{"userId" => userId}) do
    clocks = Clocks.getUserClocks(userId)
    render(conn, "index.json", clocks: clocks)
  end


  def clockUserIn(conn, %{"userId" => id}) do
    user = Api.Users.get_user!(id)
    clockExists = Clocks.checkIfExists(user.id)
    if clockExists do
      clock = Clocks.getClocksForUser(user.id)
      if clock.status == true do
        clock_params = %{"status" => false, "time" => NaiveDateTime.utc_now, "user" => user.id}
        with {:ok, %Clock{} = clock} <- Clocks.create_clock(clock_params) do
          render(conn, "show.json", clock: clock)
        end
      else
        clock_params = %{"status" => true, "time" => NaiveDateTime.utc_now, "user" => user.id}
        with {:ok, %Clock{} = clock} <- Clocks.create_clock(clock_params) do
          render(conn, "show.json", clock: clock)
        end
      end
    else
      clock_params2 = %{"status" => true, "time" => NaiveDateTime.utc_now, "user" => user.id}
      with {:ok, %Clock{} = clock2} <- Clocks.create_clock(clock_params2) do
        conn
        |> put_status(:created)
        |> render("show.json", clock: clock2)
      end
    end
  end

end
