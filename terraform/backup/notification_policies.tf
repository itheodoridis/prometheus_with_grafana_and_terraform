resource "grafana_notification_policy" "default_notification_policy" {
    group_by = ["alertname","grafana_folder"]

    contact_point = grafana_contact_point.contact_point_admincontact.name

    group_wait      = "30s"
    group_interval  = "5m"
    repeat_interval = "4h"

    # admins0003
    policy {
        matcher {
        label = "team"
        match = "="
        value = "admins0007"
        }
        contact_point = grafana_contact_point.contact_point_admins0007.name
        continue = true
    }
    # admins0001
    policy {
        matcher {
        label = "team"
        match = "="
        value = "admins0001"
        }
        contact_point = grafana_contact_point.contact_point_admins0001.name
        continue = true
    }

    # admins0005 with exception (narrow down) for mute timings on specific instances
    policy {
        matcher {
        label = "team"
        match = "="
        value = "admins0005"
        }

        contact_point = grafana_contact_point.contact_point_admins0005.name
        continue = true
        policy {
            matcher {
            label = "instance"
            match = "=~" # regex match or the or operator below will not work
            value = "srv-admins0005-01:9182|srv-admins0005-05:9182|srv-admins0005-09:9182"
            }
            continue = true
            mute_timings  = [grafana_mute_timing.weekdays_evening_till_morning.name, grafana_mute_timing.weekend.name]
        }
    }

    # nested notification policies at three levels
    policy {
        matcher {
            label = "team"
            match = "="
            value = "admins0009"
        }
        contact_point = grafana_contact_point.contact_point_admins0009.name
        continue = true

        policy {
            #contact_point = ""
            continue = true

            matcher {
                label = "target_level_label1" # these labels are defined at the target / instance level through the exporter
                match = "="
                value = "true"
            }

            mute_timings = [grafana_mute_timing.target_level_label1.name]

            policy {

                #contact_point = ""
                continue = true

                matcher {
                    label = "target_level_label2"
                    match = "="
                    value = "true"
                }

                mute_timings = [grafana_mute_timing.target_level_label1.name,grafana_mute_timing.target_level_label2.name]
            }
        }
        policy {
            #contact_point = ""
            continue = true

            matcher {
                label = "target_level_label2"
                match = "="
                value = "true"
            }

            mute_timings = [grafana_mute_timing.target_level_label2.name]
        }
        policy {
            #contact_point = ""
            continue = true

            matcher {
                label = "target_level_label3"
                match = "="
                value = "true"
            }

            mute_timings = [grafana_mute_timing.target_level_label3.name]
        }
        policy {
            #contact_point = ""
            continue = true

            matcher {
                label = "target_level_label4"
                match = "="
                value = "true"
            }
            mute_timings = [grafana_mute_timing.target_level_label5.name]
        }
    }
}