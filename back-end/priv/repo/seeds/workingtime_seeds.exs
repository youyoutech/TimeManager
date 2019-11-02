alias JsonApi.Repo
alias JsonApi.Models.Workingtime

Repo.insert! %Workingtime{
    start_day: NaiveDateTime.utc_now
        |> NaiveDateTime.truncate(:second),
    end_day: NaiveDateTime.utc_now
        |> NaiveDateTime.truncate(:second),
    users_id: 1
}

Repo.insert! %Workingtime{
    start_day: NaiveDateTime.utc_now
        |> NaiveDateTime.truncate(:second),
    end_day: NaiveDateTime.utc_now
        |> NaiveDateTime.truncate(:second),
    users_id: 1
}

Repo.insert! %Workingtime{
    start_day: ~N[2018-11-15 10:00:00],
    end_day: ~N[2030-11-15 10:00:00],
    users_id: 2
}

Repo.insert! %Workingtime{
    start_day: NaiveDateTime.utc_now
        |> NaiveDateTime.truncate(:second),
    end_day: NaiveDateTime.utc_now
        |> NaiveDateTime.truncate(:second),
    users_id: 2
}
