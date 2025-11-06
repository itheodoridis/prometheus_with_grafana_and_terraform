resource "grafana_mute_timing" "weekend" {
  name        = "Weekend"

  intervals {
    times {
      start = "00:00"
      end   = "23:59"
    }
    weekdays = ["saturday", "sunday"]
    location = "Europe/Athens"
  }
}

resource "grafana_mute_timing" "weekdays_evening_till_morning" {
  name        = "Weekdays evening till morning"

  intervals {
    times {
      start = "19:30"
      end   = "23:59"
    }
    weekdays = ["monday", "tuesday", "wednesday", "thursday", "friday"]
    location = "Europe/Athens"
  }
  intervals {
    times {
      start = "00:00"
      end   = "08:00"
    }
    weekdays = ["monday", "tuesday", "wednesday", "thursday", "friday"]
    location = "Europe/Athens"
  }
}
# Swift related Mute Timings
resource "grafana_mute_timing" "target_level_label1" {
  name = "target level label1" # Just a title / description, make it self explanatory

  intervals {

    times {
      start = "03:00"
      end   = "04:00"
    }

    weekdays = ["monday", "tuesday", "thursday", "wednesday", "friday", "saturday", "sunday"]
    location = "Europe/Athens"
  }
}

resource "grafana_mute_timing" "target level label2" {
  name = "target level label2"

  intervals {

    times {
      start = "19:30"
      end   = "22:30"
    }

    weekdays = ["saturday"]
    location = "Europe/Athens"
  }
}

resource "grafana_mute_timing" "target level label3" {
  name = "target level label3"

  intervals {

    times {
      start = "03:55"
      end   = "07:35"
    }

    weekdays = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
    location = "Europe/Athens"
  }
  intervals {
    weekdays = ["saturday", "sunday"]
    location = "Europe/Athens"
  }
  intervals {

    times {
      start = "00:00"
      end   = "03:55"
    }

    weekdays = ["monday"]
    location = "Europe/Athens"
  }
}

resource "grafana_mute_timing" "target level label4" {
  name = "target level label4"

  intervals {

    times {
      start = "03:55"
      end   = "06:05"
    }

    weekdays = ["monday", "tuesday", "wednesday", "thursday", "friday"]
    location = "Europe/Athens"
  }
  intervals {
    weekdays = ["saturday", "sunday"]
    location = "Europe/Athens"
  }
  intervals {

    times {
      start = "00:00"
      end   = "03:55"
    }

    weekdays = ["monday"]
  }
}