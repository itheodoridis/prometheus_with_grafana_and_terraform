resource "grafana_data_source" "prometheus" {
  name       = "prometheus"
  type       = "prometheus"
  url        = "http://prometheus:9090"
  uid        = "prometheus-uid"
  is_default = true

  json_data_encoded = jsonencode({
    "httpMethod":"POST",
    "prometheusType": "Prometheus",
    "prometheusVersion": "2.50.0",
    "tlsAuth": false,
    "tlsAuthWithCACert": false,
    "tlsCACert": "",
    "tlsClientCert": "",
    "tlsClientKey": "",
    "keepCookies": [],
    "timeInterval":"30s",
    "queryTimeout":"60s",
    "tlsSkipVerify": true
  })
}
