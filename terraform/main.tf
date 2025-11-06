terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "4.5.3" // adjust version if needed
    }
  }
}

provider "grafana" {
  url = var.grafana_url  // adjust if necessary
  //auth = var.grafana_api_key
  auth = var.grafaba_basic_auth
}

/*resource "grafana_dashboard" "example" {
  config_json = <<-EOF
  {
    "title": "Example Dashboard",
    "panels": []
  }
  EOF
}*/
