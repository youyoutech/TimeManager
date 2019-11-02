defmodule JsonApi.Repo.Migrations.TriggerWorkingTime do
  use Ecto.Migration

  def change do
    execute "CREATE OR REPLACE FUNCTION get_last_clockin(new_user_id bigint) RETURNS timestamp AS $$
    BEGIN
      RETURN (SELECT time
        FROM clocks
        WHERE users_id = new_user_id
        ORDER BY time DESC LIMIT 1
      );
    END;
    $$ LANGUAGE plpgsql;"

    execute "
    CREATE OR REPLACE FUNCTION trigger_clock() RETURNS trigger AS $BODY$
    BEGIN
      IF (NEW.status IS FALSE) THEN
        INSERT INTO workingtimes(start_day, end_day, users_id)
        VALUES (get_last_clockin(NEW.users_id), NEW.time, NEW.users_id);
      END IF;
      RETURN NEW;
    END;
    $BODY$ LANGUAGE plpgsql;"

    execute "DROP TRIGGER IF EXISTS InsertWorkingtimeWhenClockOut ON clocks;"

    execute "
    CREATE TRIGGER InsertWorkingtimeWhenClockOut
    BEFORE INSERT ON clocks
    FOR EACH ROW EXECUTE PROCEDURE trigger_clock();"
  end
end
