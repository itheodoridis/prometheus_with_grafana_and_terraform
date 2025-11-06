resource "grafana_folder_permission" "admins0001_permission" {
  folder_uid = grafana_folder.admins0001.uid
  permissions {
    team_id    = grafana_team.Operators.id
    permission = "View"
  }
  permissions {
    team_id    = grafana_team.admins0001.id
    permission = "Edit"
  }
}

resource "grafana_folder_permission" "admins0005_permission" {
  folder_uid = grafana_folder.admins0005.uid
  permissions {
    team_id    = grafana_team.Operators.id
    permission = "View"
  }
  permissions {
    team_id    = grafana_team.admins0005.id
    permission = "Edit"
  }
}

resource "grafana_folder_permission" "Common_permission" {
  folder_uid = grafana_folder.Common.uid
  permissions {
    team_id    = grafana_team.Operators.id
    permission = "View"
  }
}

resource "grafana_folder_permission" "Test_Area_permission" {
  folder_uid = grafana_folder.Test_Area.uid
  permissions {
    team_id    = grafana_team.Operators.id
    permission = "View"
  }
}

resource "grafana_folder_permission" "Applications_Test_Area_permission" {
  folder_uid = grafana_folder.Applications_Test_Area.uid
  permissions {
    team_id    = grafana_team.Admins0409.id
    permission = "View"
  }
  permissions {
    team_id    = grafana_team.WebAdmins.id
    permission = "View"
  }
}