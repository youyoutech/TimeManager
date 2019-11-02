defmodule JsonApiWeb.ClockView do
  use JsonApiWeb, :view
  alias JsonApiWeb.ClockView

  def render("index.json", %{clocks: clocks}) do
    %{data: render_many(clocks, ClockView, "clock.json")}
  end

  def render("show.json", %{clock: clock}) do
    %{data: render_one(clock, ClockView, "clock.json")}
  end

  def render("clock.json", %{clock: clock}) do
    %{id: clock.id,
    status: clock.status,
    time: clock.time,
    users_id: clock.users_id}
  end

  def render("status.json", %{clock: clock}) do
    %{status: clock.status}
  end
end
