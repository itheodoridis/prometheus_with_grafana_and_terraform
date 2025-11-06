resource "grafana_contact_point" "contact_point_admins0007" {
  name = "admins0007"
  org_id = 1

  email {
    addresses    = [
      "user1@company.com",
      "user2@company.com",
      "user3@company.com",
    ]
    single_email = false
    subject = "{{ template \"email.title\" . }}"
    #message = "{{ template \"email.message\" .}}"
  }

  teams {
    url = "https://company.webhook.office.com/webhookb2/lalalala1/IncomingWebhook/lalalala2"
    title = "{{ template \"email.title\" . }}"
  }
}
resource "grafana_contact_point" "contact_point_admins0001" {
  name = "admins0001"
  org_id = 1

  email {
    addresses    = [
      "user4@company.com",
      "user5@company.com",
    ]
    single_email = false
    subject = "{{ template \"email.title\" . }}"
    #message = "{{ template \"email.message\" .}}"
  }

  teams {
    url = "https://company.webhook.office.com/webhookb2/lalalala1/IncomingWebhook/lalalala3"
    title = "{{ template \"email.title\" . }}"
  }
}

resource "grafana_contact_point" "contact_point_admincontact" {
  name = "admincontact"
  org_id = 1

  email {
    addresses    = ["user6@company.com"]
    single_email = false

    subject = "{{ template \"email.title\" . }}"
    #message = "{{ template \"email.default.html\" .}}"
  }
}