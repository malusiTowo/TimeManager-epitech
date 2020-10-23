defmodule ApiWeb.WorkingtimesView do
  use ApiWeb, :view
  alias ApiWeb.WorkingtimesView

  def render("index.json", %{working_times: working_times}) do
    %{data: render_many(working_times, WorkingtimesView, "workingtimes.json")}
  end

  def render("show.json", %{workingtimes: workingtimes}) do
    %{data: render_one(workingtimes, WorkingtimesView, "workingtimes.json")}
  end

  def render("workingtimes.json", %{workingtimes: workingtimes}) do
    %{id: workingtimes.id,
      start: workingtimes.start,
      end: workingtimes.end}
  end
end
