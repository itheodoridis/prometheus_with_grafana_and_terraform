variable "grafana_api_key" {
    type    = string
    default = "theapikey_value"
}

variable "grafana_url" {
    type    = string
    default = "https://srv-pgslm-01.company.com:3000"
}

variable "grafaba_basic_auth" {
    type = string
    default = "admin:admin_password"
}
