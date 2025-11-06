resource "grafana_user" "admin" {
  name     = "adminname adminlastname"
  email    = "admin@localhost"
  login    = "admin"
  password = "dummy password"
  is_admin = true

  lifecycle {
    ignore_changes = [
      password,
    ]
  }
}

resource "grafana_user" "username1" {
  name     = "name1 lastname1"
  email    = "username1@company.com"
  login    = "username1"
  password = "dummy password"
  is_admin = false

  lifecycle {
    ignore_changes = [
      password,
    ]
  }
}

resource "grafana_user" "username2" {
  name     = "name2 lastname2"
  email    = "username2@company.com"
  login    = "username2"
  password = "dummy password"
  is_admin = false

  lifecycle {
    ignore_changes = [
      password,
    ]
  }
}

resource "grafana_user" "username3" {
  name     = "name3 lastname3"
  email    = "username3@company.com"
  login    = "username3"
  password = "dummy password"
  is_admin = false

  lifecycle {
    ignore_changes = [
      password,
    ]
  }
}

resource "grafana_user" "username4" {
  name     = "name4 lastname4"
  email    = "username4@company.com"
  login    = "username4"
  password = "dummy password"
  is_admin = false

  lifecycle {
    ignore_changes = [
      password,
    ]
  }
}

resource "grafana_user" "username5" {
  name     = "name5 lastname5"
  email    = "username5@company.com"
  login    = "username5"
  password = "dummy password"
  is_admin = false

  lifecycle {
    ignore_changes = [
      password,
    ]
  }
}

resource "grafana_user" "username6" {
  name     = "name6 lastname6"
  email    = "username6@company.com"
  login    = "username6"
  password = "dummy password"
  is_admin = false

  lifecycle {
    ignore_changes = [
      password,
    ]
  }
}

resource "grafana_user" "username7" {
  name     = "name7 lastname7"
  email    = "username7@company.com"
  login    = "username7"
  password = "dummy password"
  is_admin = false

  lifecycle {
    ignore_changes = [
      password,
    ]
  }
}

resource "grafana_user" "username8" {
  name     = "name8 lastname8"
  email    = "username8@company.com"
  login    = "username8"
  password = "dummy password"
  is_admin = false

  lifecycle {
    ignore_changes = [
      password,
    ]
  }
}

resource "grafana_team" "admins0001" {
  name  = "admins0001"
  members = [
    grafana_user.username1.email,
    grafana_user.username2.email,
  ]
  lifecycle {
    ignore_changes = [
      preferences,
    ]
  }
}

resource "grafana_team" "admins0005" {
  name  = "admins0005"
  members = [
    grafana_user.username3.email,
  ]
  lifecycle {
    ignore_changes = [
      preferences,
    ]
  }
}

resource "grafana_team" "admins0004" {
  name  = "admins0004"
  members = [
    grafana_user.username4.email,
    grafana_user.username5.email,
    grafana_user.username6.email,
  ]
  lifecycle {
    ignore_changes = [
      preferences,
    ]
  }
}

resource "grafana_team" "Operators" {
  name  = "Operators"
  members = [
    grafana_user.username7.email,
    grafana_user.username8.email,
  ]
  lifecycle {
    ignore_changes = [
      preferences,
    ]
  }
}

resource "grafana_organization" "main" {
  name         = "The name of the Company or Organization"
  admin_user   = "admin"        # keep the built-in admin listed
  create_users = false          # users already exist at this stage, no need to create them again

  admins = [
    #"admin@localhost", # probably no need to add the admin in admins
    "username3@company.com",
  ]
  
  editors = [
    "username7@company.com",
    "username8@company.com",
  ]

  viewers = [
    "username1@company.com",
    "username2@company.com",
    "username4@company.com",
    "username5@company.com",
    "username6@company.com",
  ]
}