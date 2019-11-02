defmodule JsonApiWeb.WorkingtimeView do
  use JsonApiWeb, :view
  alias JsonApiWeb.WorkingtimeView

  def render("index.json", %{workingtimes: workingtimes}) do
    %{data: render_many(workingtimes, WorkingtimeView, "workingtime.json")}
  end

  def render("show.json", %{workingtime: workingtime}) do
    %{data: render_one(workingtime, WorkingtimeView, "workingtime.json")}
  end

  def render("workingtime.json", %{workingtime: workingtime}) do
    %{id: workingtime.id,
    start_day: workingtime.start_day,
    end_day: workingtime.end_day,
    users_id: workingtime.users_id}
  end
end
