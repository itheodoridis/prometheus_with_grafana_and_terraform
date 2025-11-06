resource "grafana_dashboard" "Alerts_List_Dashboard_admins0001" {
  folder = grafana_folder.admins0001_Alerts.uid
  config_json = file("Alerts_List_Dashboard_admins0001.json")
}
resource "grafana_dashboard" "Windows_Exporter_Dashboard_2024_admins0001" {
  folder = grafana_folder.Windows_Servers_admins0001.uid
  config_json = file("Windows_Exporter_Dashboard_2024_admins0001.json")
}

resource "grafana_dashboard" "Alerts_List_Dashboard_admins0005" {
  folder = grafana_folder.admins0005_Alerts.uid
  config_json = file("Alerts_List_Dashboard_admins0005.json")
}
resource "grafana_dashboard" "Windows_Exporter_Dashboard_2024_admins0005" {
  folder = grafana_folder.Windows_Servers_admins0005.uid
  config_json = file("Windows_Exporter_Dashboard_2024_admins0005.json")
}
resource "grafana_dashboard" "Node_Exporter_Dashboard_admins0005" {
  folder = grafana_folder.Linux_Servers_admins0005.uid
  config_json = file("Node_Exporter_Dashboard_admins0005.json")
}
resource "grafana_dashboard" "Process_Exporter_Dashboard_admins0005" {
  folder = grafana_folder.Linux_Servers_admins0005.uid
  config_json = file("Process_Exporter_Dashboard_admins0005.json")
}
