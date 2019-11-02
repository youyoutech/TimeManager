defmodule JsonApi.Repo.Migrations.InsertAdmin do
  use Ecto.Migration

  def change do

    execute"INSERT INTO users (username, email, password_hash, role_id, team_id, inserted_at, updated_at) VALUES ('CEO', 'ceo@mail.com', '$argon2i$v=19$m=65536,t=6,p=1$rHudWJHInSuYhkw8HjQp+w$+TdCCgqXI11alSJ4sC1ALtPMhv4ry3aR882nCge0q/Q', '3', '1', NOW(), NOW())"

  end
end
