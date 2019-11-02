defmodule JsonApiWeb.Router do
  use JsonApiWeb, :router
  import JsonApi.Plug.Role

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  #All the request from the api
  pipeline :api do
    plug :accepts, ["json"]
  end

  #The request that needs the token in header
  pipeline :api_auth do
    plug(JsonApi.Auth.Pipeline)
  end

  #The request that need an admin user to be done passed in parameter
  pipeline :admin do
    plug :is_admin
  end

  #The request that need an admin or manager user to be done passed in parameter
  pipeline :manager do
    plug :is_manager
  end

  #Other scopes may use custom stacks.
  scope "/api", JsonApiWeb do
    pipe_through :api

    post("/login", SessionController, :create)
    post("/register", UsersController, :create)
  end

  scope "/api", JsonApiWeb do
    pipe_through([:api, :api_auth])

    delete("/logout", SessionController, :delete)
    post("/login/refresh", SessionController, :refresh)

    scope "/users" do
      resources "/", UsersController, except: [:new, :edit, :index, :update]
      get "/", UsersController, :show_by_infos
      put "/:id", UsersController, :edit
      get"/:id/team", UsersController, :get_team_mates
      # options "/", UsersController, :nothing
    end

    scope "/clock" do
      resources "/", ClockController, only: [:create]
      get "/:id", ClockController, :get_clocks_by_userid
      get "/:id/last", ClockController, :get_last_status
    end

    scope "/team" do
      pipe_through([:admin])
      resources "/", TeamController, only: [:create, :delete, :index, :show, :update]
    end

    scope "/workingtime" do
      resources "/", WorkingtimeController, only: [:create, :update, :delete, :show]
      get "/:id/date", WorkingtimeController, :show_by_user_and_date
      get "/:id/all", WorkingtimeController, :get_all_workingtime
    end

    scope "/manager" do
      pipe_through([:manager])
      get "/team/:teamid", UsersController, :list_users_from_manager_by_team
    end

    scope "/admin" do
      pipe_through([:admin])
      get "/users/team/:teamid", UsersController, :list_users_from_admin_by_team
      get "/users", UsersController, :list_all_users_from_admin
      get "/team/:teamid/count", UsersController, :count_users_in_team
      get "/users/clocks", UsersController, :list_all_users_from_admin_with_clocks
    end
  end

  scope "/", JsonApiWeb do
    get "/*path", FourOFourController, :index
    post "/*path", FourOFourController, :index
    put "/*path", FourOFourController, :index
    delete "/*path", FourOFourController, :index
  end
end
