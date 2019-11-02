alias JsonApi.Repo
alias JsonApi.Models.Clock

# On fait un seeds qui push une semaine en db directement

# Lundi
Repo.insert! %Clock{
    time: ~N[2019-09-10 08:00:00],
    status: true,
    users_id: 1
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 12:00:00],
    status: false,
    users_id: 1
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 14:00:00],
    status: true,
    users_id: 1
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 18:00:00],
    status: false,
    users_id: 1
}

# Mardi
Repo.insert! %Clock{
    time: ~N[2019-09-11 08:00:00],
    status: true,
    users_id: 1
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 12:00:00],
    status: false,
    users_id: 1
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 14:00:00],
    status: true,
    users_id: 1
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 18:00:00],
    status: false,
    users_id: 1
}

# Mercredi
Repo.insert! %Clock{
    time: ~N[2019-09-12 08:00:00],
    status: true,
    users_id: 1
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 11:00:00],
    status: false,
    users_id: 1
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 14:00:00],
    status: true,
    users_id: 1
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 18:45:00],
    status: false,
    users_id: 1
}

# Jeudi
Repo.insert! %Clock{
    time: ~N[2019-09-13 09:00:00],
    status: true,
    users_id: 1
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 12:00:00],
    status: false,
    users_id: 1
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 13:30:00],
    status: true,
    users_id: 1
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 18:15:00],
    status: false,
    users_id: 1
}

# Vendredi
Repo.insert! %Clock{
    time: ~N[2019-09-14 08:30:00],
    status: true,
    users_id: 1
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 12:15:00],
    status: false,
    users_id: 1
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 13:30:00],
    status: true,
    users_id: 1
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 16:15:00],
    status: false,
    users_id: 1
}

#User 2

Repo.insert! %Clock{
    time: ~N[2019-09-10 08:00:00],
    status: true,
    users_id: 2
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 12:00:00],
    status: false,
    users_id: 2
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 14:00:00],
    status: true,
    users_id: 2
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 18:00:00],
    status: false,
    users_id: 2
}

# Mardi
Repo.insert! %Clock{
    time: ~N[2019-09-11 08:00:00],
    status: true,
    users_id: 2
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 12:00:00],
    status: false,
    users_id: 2
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 14:00:00],
    status: true,
    users_id: 2
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 18:00:00],
    status: false,
    users_id: 2
}

# Mercredi
Repo.insert! %Clock{
    time: ~N[2019-09-12 08:00:00],
    status: true,
    users_id: 2
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 11:00:00],
    status: false,
    users_id: 2
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 14:00:00],
    status: true,
    users_id: 2
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 18:45:00],
    status: false,
    users_id: 2
}

# Jeudi
Repo.insert! %Clock{
    time: ~N[2019-09-13 09:00:00],
    status: true,
    users_id: 2
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 12:00:00],
    status: false,
    users_id: 2
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 13:30:00],
    status: true,
    users_id: 2
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 18:15:00],
    status: false,
    users_id: 2
}

# Vendredi
Repo.insert! %Clock{
    time: ~N[2019-09-14 08:30:00],
    status: true,
    users_id: 2
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 12:15:00],
    status: false,
    users_id: 2
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 13:30:00],
    status: true,
    users_id: 2
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 16:15:00],
    status: false,
    users_id: 2
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 08:00:00],
    status: true,
    users_id: 3
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 12:00:00],
    status: false,
    users_id: 3
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 14:00:00],
    status: true,
    users_id: 3
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 18:00:00],
    status: false,
    users_id: 3
}

# Mardi
Repo.insert! %Clock{
    time: ~N[2019-09-11 08:00:00],
    status: true,
    users_id: 3
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 12:00:00],
    status: false,
    users_id: 3
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 14:00:00],
    status: true,
    users_id: 3
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 18:00:00],
    status: false,
    users_id: 3
}

# Mercredi
Repo.insert! %Clock{
    time: ~N[2019-09-12 08:00:00],
    status: true,
    users_id: 3
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 11:00:00],
    status: false,
    users_id: 3
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 14:00:00],
    status: true,
    users_id: 3
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 18:45:00],
    status: false,
    users_id: 3
}

# Jeudi
Repo.insert! %Clock{
    time: ~N[2019-09-13 09:00:00],
    status: true,
    users_id: 3
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 12:00:00],
    status: false,
    users_id: 3
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 13:30:00],
    status: true,
    users_id: 3
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 18:15:00],
    status: false,
    users_id: 3
}

# Vendredi
Repo.insert! %Clock{
    time: ~N[2019-09-14 08:30:00],
    status: true,
    users_id: 3
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 12:15:00],
    status: false,
    users_id: 3
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 13:30:00],
    status: true,
    users_id: 3
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 16:15:00],
    status: false,
    users_id: 3
}

#User 2

Repo.insert! %Clock{
    time: ~N[2019-09-10 08:00:00],
    status: true,
    users_id: 6
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 12:00:00],
    status: false,
    users_id: 6
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 14:00:00],
    status: true,
    users_id: 6
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 18:00:00],
    status: false,
    users_id: 6
}

# Mardi
Repo.insert! %Clock{
    time: ~N[2019-09-11 08:00:00],
    status: true,
    users_id: 6
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 12:00:00],
    status: false,
    users_id: 6
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 14:00:00],
    status: true,
    users_id: 6
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 18:00:00],
    status: false,
    users_id: 6
}

# Mercredi
Repo.insert! %Clock{
    time: ~N[2019-09-12 08:00:00],
    status: true,
    users_id: 6
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 11:00:00],
    status: false,
    users_id: 6
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 14:00:00],
    status: true,
    users_id: 6
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 18:45:00],
    status: false,
    users_id: 6
}

# Jeudi
Repo.insert! %Clock{
    time: ~N[2019-09-13 09:00:00],
    status: true,
    users_id: 6
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 12:00:00],
    status: false,
    users_id: 6
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 13:30:00],
    status: true,
    users_id: 6
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 18:15:00],
    status: false,
    users_id: 6
}

# Vendredi
Repo.insert! %Clock{
    time: ~N[2019-09-14 08:30:00],
    status: true,
    users_id: 6
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 12:15:00],
    status: false,
    users_id: 6
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 13:30:00],
    status: true,
    users_id: 6
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 16:15:00],
    status: false,
    users_id: 6
}


Repo.insert! %Clock{
    time: ~N[2019-09-10 08:00:00],
    status: true,
    users_id: 5
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 12:00:00],
    status: false,
    users_id: 5
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 14:00:00],
    status: true,
    users_id: 5
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 18:00:00],
    status: false,
    users_id: 5
}

# Mardi
Repo.insert! %Clock{
    time: ~N[2019-09-11 08:00:00],
    status: true,
    users_id: 5
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 12:00:00],
    status: false,
    users_id: 5
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 14:00:00],
    status: true,
    users_id: 5
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 18:00:00],
    status: false,
    users_id: 5
}

# Mercredi
Repo.insert! %Clock{
    time: ~N[2019-09-12 08:00:00],
    status: true,
    users_id: 5
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 11:00:00],
    status: false,
    users_id: 5
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 14:00:00],
    status: true,
    users_id: 5
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 18:45:00],
    status: false,
    users_id: 5
}

# Jeudi
Repo.insert! %Clock{
    time: ~N[2019-09-13 09:00:00],
    status: true,
    users_id: 5
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 12:00:00],
    status: false,
    users_id: 5
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 13:30:00],
    status: true,
    users_id: 5
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 18:15:00],
    status: false,
    users_id: 5
}

# Vendredi
Repo.insert! %Clock{
    time: ~N[2019-09-14 08:30:00],
    status: true,
    users_id: 5
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 12:15:00],
    status: false,
    users_id: 5
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 13:30:00],
    status: true,
    users_id: 5
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 16:15:00],
    status: false,
    users_id: 5
}

#User 2

Repo.insert! %Clock{
    time: ~N[2019-09-10 08:00:00],
    status: true,
    users_id: 4
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 12:00:00],
    status: false,
    users_id: 4
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 14:00:00],
    status: true,
    users_id: 4
}

Repo.insert! %Clock{
    time: ~N[2019-09-10 18:00:00],
    status: false,
    users_id: 4
}

# Mardi
Repo.insert! %Clock{
    time: ~N[2019-09-11 08:00:00],
    status: true,
    users_id: 4
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 12:00:00],
    status: false,
    users_id: 4
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 14:00:00],
    status: true,
    users_id: 4
}

Repo.insert! %Clock{
    time: ~N[2019-09-11 18:00:00],
    status: false,
    users_id: 4
}

# Mercredi
Repo.insert! %Clock{
    time: ~N[2019-09-12 08:00:00],
    status: true,
    users_id: 4
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 11:00:00],
    status: false,
    users_id: 4
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 14:00:00],
    status: true,
    users_id: 4
}

Repo.insert! %Clock{
    time: ~N[2019-09-12 18:45:00],
    status: false,
    users_id: 4
}

# Jeudi
Repo.insert! %Clock{
    time: ~N[2019-09-13 09:00:00],
    status: true,
    users_id: 4
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 12:00:00],
    status: false,
    users_id: 4
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 13:30:00],
    status: true,
    users_id: 4
}

Repo.insert! %Clock{
    time: ~N[2019-09-13 18:15:00],
    status: false,
    users_id: 4
}

# Vendredi
Repo.insert! %Clock{
    time: ~N[2019-09-14 08:30:00],
    status: true,
    users_id: 4
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 12:15:00],
    status: false,
    users_id: 4
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 13:30:00],
    status: true,
    users_id: 4
}

Repo.insert! %Clock{
    time: ~N[2019-09-14 16:15:00],
    status: false,
    users_id: 4
}

