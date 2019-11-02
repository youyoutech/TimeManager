defmodule JsonApiWeb.TeamView do
  use JsonApiWeb, :view
  alias JsonApiWeb.TeamView

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, TeamView, "team.json")}
  end

  def render("show.json", %{team: team}) do
    %{data: render_one(team, TeamView, "team.json")}
  end

  def render("showname.json", %{team: team}) do
    %{data: render_one(team, TeamView, "teamname.json")}
  end

  def render("team.json", %{team: team}) do
    %{id: team.id,
      name: team.name,
      user: team.users}
  end

  def render("teamname.json", %{team: team}) do
    %{id: team.id,
      name: team.name}
  end
end
