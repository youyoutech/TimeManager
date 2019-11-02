defmodule JsonApi.Models do
  @moduledoc """
  The Models context.
  """

  import Ecto.Query, warn: false
  alias JsonApi.Repo

  alias JsonApi.Models.Users
  alias JsonApi.Models.Clock
  alias JsonApi.Models.Workingtime

  def get_users_by_infos!(username, email) do
    Repo.get_by(Users, username: username, email: email)
  end

  def authenticate(email, password) do
    users = Repo.get_by(Users, email: String.downcase(email))

    case check_password(users, password) do
      true -> {:ok, users}
      _ -> :error
    end
  end

  defp check_password(users, password) do
    case users do
      nil -> Comeonin.Argon2.dummy_checkpw()
      _ -> Comeonin.Argon2.checkpw(password, users.password_hash)
    end
  end

  def list_users_from_manager(teamId) do
    query = from u in Users,
      where: u.team_id == ^teamId,
      select: %{id: u.id, username: u.username, email: u.email, team_id: u.team_id, role_id: u.role_id}
    Repo.all(query)
  end

  def get_team_mates(teamId) do
    query = from u in Users,
      where: u.team_id == ^teamId,
      select: %{id: u.id, username: u.username, email: u.email, role_id: u.role_id}
    Repo.all(query)
  end



  def list_users_from_admin_by_team(teamId) do
    query = from u in Users,
      where: u.team_id == ^teamId,
      select: %{id: u.id, username: u.username, email: u.email, team_id: u.team_id, role_id: u.role_id}
    Repo.all(query)
  end

  def list_all_users_from_admin do
    query = from u in Users,
      where: u.role_id == 1 or u.role_id == 2 or u.role_id == 3,
      select: %{id: u.id, username: u.username, email: u.email, team_id: u.team_id, role_id: u.role_id}
    Repo.all(query)
  end

  def list_all_users_from_admin_with_clocks do
    query = from u in Users,
      left_join: workingtimes in assoc(u, :workingtimes),
      preload: [workingtimes: workingtimes]
    Repo.all(query)
  end

  def count_users_in_team(teamId) do
    query = from u in Users,
      where: u.team_id ==^teamId,
      select: count("*")
    Repo.all(query) |> IO.inspect
  end

  def get_user(id) do
    Repo.get(Users, id) |> Repo.preload([:role, :team])
  end

  def create_user(attrs \\ %{}) do
    result =
      %Users{}
      |> Users.registration_changeset(attrs)
      |> Repo.insert()

    case result do
      {:ok, users} -> {:ok, %Users{users | password: nil}}
      _ -> result
    end
  end

  def update_user(%Users{} = users, attrs) do
    users
    |> Users.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%Users{} = users) do
    Repo.delete(users)
  end

  def change_user(%Users{} = users) do
    Users.changeset(users, %{})
  end

  def list_clocks do
    Repo.all(Clock)
  end
  def get_clock!(id), do: Repo.get!(Clock, id)

  def get_clocks_by_user_id!(id) do
    query = from c in Clock,
      where: c.users_id == ^id,
      select: %{id: c.id, status: c.status, time: c.time, users_id: c.users_id}
    Repo.all(query)
  end

  def get_last_clock_status!(id) do
    query = from c in Clock,
      where: c.users_id == ^id,
      order_by: [desc: c.id],
      limit: 1,
      select: %{id: c.id, status: c.status, time: c.time, users_id: c.users_id}
    Repo.all(query)
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
  Deletes a Clock.

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
      %Ecto.Changeset{source: %Clock{}}

  """
  def change_clock(%Clock{} = clock) do
    Clock.changeset(clock, %{})
  end

  alias JsonApi.Models.Workingtime

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%Workingtime{}, ...]

  """
  def list_workingtimes do
    Repo.all(Workingtime)
  end

  @doc """
  Gets a single workingtime.

  Raises `Ecto.NoResultsError` if the Workingtime does not exist.

  ## Examples

      iex> get_workingtime!(123)
      %Workingtime{}

      iex> get_workingtime!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workingtime!(id), do: Repo.get!(Workingtime, id)

  def get_workingtime_by_user_and_date!(id, start_day, end_day) do
    query = from w in Workingtime,
      where: w.start_day >= ^start_day and w.end_day <= ^end_day and w.users_id == ^id,
      select: %{id: w.id, start_day: w.start_day, end_day: w.end_day, users_id: w.users_id}
    Repo.all(query)
  end

  def get_all_workingtime!(id) do
    query = from w in Workingtime,
      where: w.users_id == ^id,
      select: %{id: w.id, start_day: w.start_day, end_day: w.end_day, users_id: w.users_id}
    Repo.all(query)
  end
  @doc """
  Creates a workingtime.

  ## Examples

      iex> create_workingtime(%{field: value})
      {:ok, %Workingtime{}}

      iex> create_workingtime(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workingtime(attrs \\ %{}) do
    %Workingtime{}
    |> Workingtime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a workingtime.

  ## Examples

      iex> update_workingtime(workingtime, %{field: new_value})
      {:ok, %Workingtime{}}

      iex> update_workingtime(workingtime, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workingtime(%Workingtime{} = workingtime, attrs) do
    workingtime
    |> Workingtime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Workingtime.

  ## Examples

      iex> delete_workingtime(workingtime)
      {:ok, %Workingtime{}}

      iex> delete_workingtime(workingtime)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workingtime(%Workingtime{} = workingtime) do
    Repo.delete(workingtime)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workingtime changes.

  ## Examples

      iex> change_workingtime(workingtime)
      %Ecto.Changeset{source: %Workingtime{}}

  """
  def change_workingtime(%Workingtime{} = workingtime) do
    Workingtime.changeset(workingtime, %{})
  end

  alias JsonApi.Models.Role

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      [%Role{}, ...]

  """
  def list_roles do
    Repo.all(Role)
  end

  @doc """
  Gets a single role.

  Raises `Ecto.NoResultsError` if the Role does not exist.

  ## Examples

      iex> get_role!(123)
      %Role{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role!(id), do: Repo.get!(Role, id)

  @doc """
  Creates a role.

  ## Examples

      iex> create_role(%{field: value})
      {:ok, %Role{}}

      iex> create_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role.

  ## Examples

      iex> update_role(role, %{field: new_value})
      {:ok, %Role{}}

      iex> update_role(role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Role.

  ## Examples

      iex> delete_role(role)
      {:ok, %Role{}}

      iex> delete_role(role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role changes.

  ## Examples

      iex> change_role(role)
      %Ecto.Changeset{source: %Role{}}

  """
  def change_role(%Role{} = role) do
    Role.changeset(role, %{})
  end

  alias JsonApi.Models.Team

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams do
    query = from t in Team,
      left_join: users in assoc(t, :users),
      preload: [users: users]
    Repo.all(query)
  end

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id) do
    query = from t in Team,
      where: t.id == ^id,
      left_join: users in assoc(t, :users),
      preload: [users: users]
    Repo.one(query)
  end


  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{source: %Team{}}

  """
  def change_team(%Team{} = team) do
    Team.changeset(team, %{})
  end

end
