alias JsonApi.Repo
alias JsonApi.Models.Users

Repo.insert! %Users{
    username: "Jack",
    password_hash: "$argon2i$v=19$m=65536,t=6,p=1$rHudWJHInSuYhkw8HjQp+w$+TdCCgqXI11alSJ4sC1ALtPMhv4ry3aR882nCge0q/Q",
    email: "jack@mail.com",
    role_id: 1,
    team_id: 1
}

Repo.insert! %Users{
    username: "Ted",
    password_hash: "$argon2i$v=19$m=65536,t=6,p=1$rHudWJHInSuYhkw8HjQp+w$+TdCCgqXI11alSJ4sC1ALtPMhv4ry3aR882nCge0q/Q",
    email: "ted@mail.com",
    role_id: 2,
    team_id: 1
}

Repo.insert! %Users{
    username: "SUPERADMIN",
    password_hash: "$argon2i$v=19$m=65536,t=6,p=1$rHudWJHInSuYhkw8HjQp+w$+TdCCgqXI11alSJ4sC1ALtPMhv4ry3aR882nCge0q/Q",
    email: "admin@mail.com",
    role_id: 3,
    team_id: 1
}

Repo.insert! %Users{
    username: "Bill",
    password_hash: "$argon2i$v=19$m=65536,t=6,p=1$rHudWJHInSuYhkw8HjQp+w$+TdCCgqXI11alSJ4sC1ALtPMhv4ry3aR882nCge0q/Q",
    email: "bill@mail.com",
    role_id: 1,
    team_id: 1
}

Repo.insert! %Users{
    username: "Fred",
    password_hash: "$argon2i$v=19$m=65536,t=6,p=1$rHudWJHInSuYhkw8HjQp+w$+TdCCgqXI11alSJ4sC1ALtPMhv4ry3aR882nCge0q/Q",
    email: "fred@mail.com",
    role_id: 2,
    team_id: 2
}

Repo.insert! %Users{
    username: "Dwayne",
    password_hash: "$argon2i$v=19$m=65536,t=6,p=1$rHudWJHInSuYhkw8HjQp+w$+TdCCgqXI11alSJ4sC1ALtPMhv4ry3aR882nCge0q/Q",
    email: "dwayne@mail.com",
    role_id: 1,
    team_id: 2
}
