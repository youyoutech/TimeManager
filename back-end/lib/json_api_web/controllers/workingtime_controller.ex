defmodule JsonApiWeb.WorkingtimeController do
  use JsonApiWeb, :controller

  alias JsonApi.Models
  alias JsonApi.Models.Workingtime

  action_fallback(JsonApiWeb.FallbackController)

  def index(conn, _params) do
    workingtimes = Models.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, params) do
    with {:ok, %Workingtime{} = workingtime} <- Models.create_workingtime(params) do
      conn
      |> put_status(:created)
      |> render("show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"id" => id}) do
    workingtime = Models.get_workingtime!(id)
    render(conn, "show.json", workingtime: workingtime)
  end

  def show_by_user_and_date(conn, %{"id"=> id, "start_day" => start_day, "end_day" => end_day}) do
    workingtime = Models.get_workingtime_by_user_and_date!(id, start_day, end_day)
    render(conn, "index.json", workingtimes: workingtime)
  end

  def get_all_workingtime(conn, %{"id"=> id}) do
    workingtime = Models.get_all_workingtime!(id)
    render(conn, "index.json", workingtimes: workingtime)
  end

  def update(conn, %{"id" => id} = params) do
    workingtime = Models.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Models.update_workingtime(workingtime, params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Models.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Models.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
