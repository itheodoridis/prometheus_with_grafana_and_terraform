resource "grafana_folder" "admins0001" {
  title = "admins0001"
}

resource "grafana_folder" "admins0001_Alerts" {
  title = "admins0001 Alerts"
  parent_folder_uid = grafana_folder.admins0001.uid
}

resource "grafana_folder" "Windows_Servers_admins0001" {
  title = "Windows Servers admins0001"
  parent_folder_uid = grafana_folder.admins0001.uid
}

resource "grafana_folder" "Common" {
  title = "Common"
}

resource "grafana_folder" "Linux_Alerts_Common" {
  title = "Linux Alerts Common"
  parent_folder_uid = grafana_folder.Common.uid
}

resource "grafana_folder" "Linux_Servers_Common" {
  title = "Linux Servers Common"
  parent_folder_uid = grafana_folder.Common.uid
}

resource "grafana_folder" "Windows_Alerts_Common" {
  title = "Windows Alerts Common"
  parent_folder_uid = grafana_folder.Common.uid
}

resource "grafana_folder" "Windows_Servers_Common" {
  title = "Windows Servers Common"
  parent_folder_uid = grafana_folder.Common.uid
}

resource "grafana_folder" "admins0005" {
  title = "admins0005"
}
resource "grafana_folder" "admins0005_Alerts" {
  title             = "admins0005 Alerts"
  parent_folder_uid = grafana_folder.admins0005.uid
}
resource "grafana_folder" "Linux_Servers_admins0005" {
  title             = "Linux Servers admins0005"
  parent_folder_uid = grafana_folder.admins0005.uid
}
resource "grafana_folder" "Windows_Servers_admins0005" {
  title             = "Windows Servers admins0005"
  parent_folder_uid = grafana_folder.admins0005.uid
}



resource "grafana_folder" "Test_Area" {
  title = "Test Area"
}

resource "grafana_folder" "Alerts_Test_Area" {
  title             = "Alerts Test Area"
  parent_folder_uid = grafana_folder.Test_Area.uid
}
resource "grafana_folder" "Applications_Test_Area" {
  title             = "Applications Test Area"
  parent_folder_uid = grafana_folder.Test_Area.uid
}
resource "grafana_folder" "Linux_Servers_Test_Area" {
  title             = "Linux Servers Test Area"
  parent_folder_uid = grafana_folder.Test_Area.uid
}
resource "grafana_folder" "Windows_Servers_Test_Area" {
  title             = "Windows Servers Test Area"
  parent_folder_uid = grafana_folder.Test_Area.uid
}