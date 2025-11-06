# Common Server and Services Alerts per team
# team = admins0001
resource "grafana_rule_group" "rule_group_admins0001" {
  //org_id           = 1
  name             = "admins0001 AlertGroup"
  folder_uid       = grafana_folder.admins0001_Alerts.uid
  interval_seconds = 300

  # service alerts
  # SQL Server
  rule {
    name      = "MSSQL Server Service"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"windows_service_state{team=\\\"admins0001\\\", name=\\\"MSSQLSERVER\\\",state=\\\"running\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "OK"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      summary = "When alert is active, MSSQL Server Service is not running"
      description = "When alert is active, MSSQLSERVER service on {{ $labels.instance }} is not running. If needed, check the service status."
    }
    labels = {
      "alert_type" = "service"
    }
  }
  # SQL Server Agent
  rule {
    name      = "MSSQL Server Agent Service"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"windows_service_state{team=\\\"admins0001\\\", name=\\\"SQLSERVERAGENT\\\",state=\\\"running\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "OK"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      summary = "When alert is active, MSSQL Server Agent Service is not running"
      description = "When alert is active, SQLSERVERAGENT service on {{ $labels.instance }} is not running. If needed, check the service status."
    }
    labels = {
      "alert_type" = "service"
    }
  }
  # server down
  rule {
    name      = "WindowsInstanceDown"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"up{team=\\\"admins0001\\\",exporter_type=\\\"winexporter\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      summary = "When alert is active, Windows Instance is down"
      description = "When alert is active, Windows instance {{ $labels.instance }} is down or unreachable. If needed, check the host status."
    }
    labels = {
      "alert_type" = "instance"
    }
  }
  # disk space with exception of J volume/drive
  rule {
    name      = "WindowsHardDiskVolumeWarning"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"round(100-(windows_logical_disk_free_bytes{team=\\\"admins0001\\\",exporter_type=\\\"winexporter\\\",environment=\\\"prod\\\",volume!~\\\".*Harddisk.*\\\",volume!~\\\"J:\\\"}/windows_logical_disk_size_bytes{team=\\\"admins0001\\\",exporter_type=\\\"winexporter\\\",environment=\\\"prod\\\",volume!~\\\".*Harddisk.*\\\",volume!~\\\"J:\\\"}) * 100,0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "C"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = "prometheus-uid"
      model          = "{\"datasource\":{\"type\":\"prometheus\",\"uid\":\"prometheus-uid\"},\"editorMode\":\"code\",\"expr\":\"round(windows_logical_disk_free_bytes{team=\\\"admins0001\\\",exporter_type=\\\"winexporter\\\",environment=\\\"prod\\\",volume!~\\\".*Harddisk.*\\\",volume!~\\\"J:\\\"}/(1024*1000*1000),0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"C\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[0,0],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[]},\"reducer\":{\"params\":[],\"type\":\"avg\"},\"type\":\"query\"}],\"datasource\":{\"name\":\"Expression\",\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"$A > 98.6 && $C < 11\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"math\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      __dashboardUid__ = grafana_dashboard.Windows_Exporter_Dashboard_2024_admins0001.uid
      __panelId__     = "23"
      summary = "When alert is active, Low Disk Space on {{ $labels.instance }} (Volume: {{ $labels.volume }})"
      description = "When alert is active, disk space on volume {{ $labels.volume }} of instance {{ $labels.instance }} is above 98.6% and free space is below 11 GBs. Current used space is {{ index .Values \"A\" }}% and free space is  {{ index .Values \"C\" }}. If needed, take action to free up space."
    }
    labels = {
      "alert_type" = "disk"
    }    
  }
  # CPU usage
  rule {
    name      = "WindowsCPUPercWarning"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"round((1 - irate(windows_cpu_time_total{team=\\\"admins0001\\\",exporter_type=\\\"winexporter\\\",mode=\\\"idle\\\"}[15m])) * 100,0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[90],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      __dashboardUid__ = grafana_dashboard.Windows_Exporter_Dashboard_2024_admins0001.uid
      __panelId__     = "19"
      summary = "When alert is active, High CPU Usage on {{ $labels.instance }}"
      description = "When alert is active, CPU usage on instance {{ $labels.instance }} is above 90%. Current load is {{ index .Values \"A\" }}%. If needed, investigate the cause."
    }
    labels = {
      "alert_type" = "cpu"
    }    
  }
  # Windows Memory
  rule {
    name      = "Windows Memory"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"round(100 * (windows_os_physical_memory_free_bytes{team=\\\"admins0001\\\",exporter_type=\\\"winexporter\\\"}/windows_cs_physical_memory_bytes{team=\\\"admins0001\\\",exporter_type=\\\"winexporter\\\"}),0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[2],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "3m"
    is_paused      = false
    annotations = {
      __dashboardUid__ = grafana_dashboard.Windows_Exporter_Dashboard_2024_admins0001.uid
      __panelId__     = "21"
      summary = "When alert is active, Low Memory on {{ $labels.instance }}"
      description = "When alert is active, available memory on instance {{ $labels.instance }} is below 2%. Current available memory is {{ index .Values \"A\"}}%. If needed, investigate the cause."
    }
    labels = {
      "alert_type" = "memory"
    }  
  }
}
# team = admins0005
resource "grafana_rule_group" "rule_group_admins0005" {
  //org_id           = 1
  name             = "admins0005 AlertGroup"
  folder_uid       = grafana_folder.admins0005_Alerts.uid
  interval_seconds = 300

  # internet websites text searches
  # cnn
  rule {
    name      = "Admins CNN text search"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"probe_success{job=\\\"blackbox_https_texts\\\", module=\\\"https_text_cnn\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "OK"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      summary = "When alert is active, text search on CNN Website has failed"
      description = "When alert is active, text search on CNN website is not successful. If needed, check the website or the monitoring configuration."
    }
    labels = {
      "alert_type" = "content"
    }
  }

  # Federal Reserve
  rule {
    name      = "Federal Reserve text search"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"probe_success{job=\\\"blackbox_https_texts\\\", module=\\\"https_text_federalreserve\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "OK"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      summary = "When alert is active, text search on Federal Reserve Website failed"
      description = "When alert is active, text search on Federal Reserve website is not successful. If needed, check the website or the monitoring configuration."
    }
    labels = {
      "alert_type" = "content"
    }
  }

  # windows server down
  rule {
    name      = "WindowsInstanceDown"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"up{team=\\\"admins0005\\\",exporter_type=\\\"winexporter\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      summary = "When alert is active, Windows Instance is down"
      description = "When alert is active, Windows instance {{ $labels.instance }} is down or unreachable. If needed, check the host status."
    }
    labels = {
      "alert_type" = "instance"
    }
  }
  # disk space
  rule {
    name      = "WindowsHardDiskVolumeWarning"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"round(100-(windows_logical_disk_free_bytes{team=\\\"admins0005\\\",exporter_type=\\\"winexporter\\\", volume!~\\\".*Harddisk.*\\\"}/windows_logical_disk_size_bytes{team=\\\"admins0005\\\",exporter_type=\\\"winexporter\\\", volume!~\\\".*Harddisk.*\\\"}) * 100,0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[85],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      __dashboardUid__ = grafana_dashboard.Windows_Exporter_Dashboard_2024_admins0005.uid
      __panelId__     = "23"
      summary = "When alert is active, Low Disk Space on {{ $labels.instance }} (Volume: {{ $labels.volume }})"
      description = "When alert is active, disk space on volume {{ $labels.volume }} of instance {{ $labels.instance }} is above 85%. Current used space is {{ index .Values \"A\" }}%. If needed, take action to free up space."
    }
    labels = {
      "alert_type" = "disk"
    }
  }
  # CPU usage
  rule {
    name      = "WindowsCPUPercWarning"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"round((1 - irate(windows_cpu_time_total{team=\\\"admins0005\\\",exporter_type=\\\"winexporter\\\",mode=\\\"idle\\\"}[5m])) * 100,0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[85],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      __dashboardUid__ = grafana_dashboard.Windows_Exporter_Dashboard_2024_admins0005.uid
      __panelId__     = "19"
      summary = "When alert is active, High CPU Usage on {{ $labels.instance }}"
      description = "When alert is active, CPU usage on instance {{ $labels.instance }} is above 85%. Current load is {{ index .Values \"A\" }}%. If needed, investigate the cause."
    }
    labels = {
      "alert_type" = "cpu"
    }
  }
  # Windows Memory
  rule {
    name      = "Windows Memory"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"round(100 * (windows_os_physical_memory_free_bytes{team=\\\"admins0005\\\",exporter_type=\\\"winexporter\\\"}/windows_cs_physical_memory_bytes{team=\\\"admins0005\\\",exporter_type=\\\"winexporter\\\"}),0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[15],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "3m"
    is_paused      = false
    annotations = {
      __dashboardUid__ = grafana_dashboard.Windows_Exporter_Dashboard_2024_admins0005.uid
      __panelId__     = "21"
      summary = "When alert is active, Low Memory on {{ $labels.instance }}"
      description = "When alert is active, available memory on instance {{ $labels.instance }} is below 15%. Current available memory is {{ index .Values \"A\"}}%. If needed, investigate the cause."
    }
    labels = {
      "alert_type" = "memory"
    }
  }

  # Linux server down
  rule {
    name      = "LinuxInstanceDown"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"up{team=\\\"admins0005\\\",exporter_type=\\\"node\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1,0],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[]},\"reducer\":{\"params\":[],\"type\":\"avg\"},\"type\":\"query\"}],\"datasource\":{\"name\":\"Expression\",\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "3m"
    is_paused      = false
    labels = {
      "alert_type" = "instance"
    }
  }
  # Linux partition space
  rule {
    name      = "LinuxMainPartitionSpaceRunningOut"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"round(100 - ((node_filesystem_avail_bytes{team=\\\"admins0005\\\",exporter_type=\\\"node\\\",fstype!=\\\"rootfs\\\",mountpoint=\\\"/\\\"} * 100) / node_filesystem_size_bytes{team=\\\"admins0005\\\",exporter_type=\\\"node\\\",fstype!=\\\"rootfs\\\",mountpoint=\\\"/\\\"}), 0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[85,0],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[]},\"reducer\":{\"params\":[],\"type\":\"avg\"},\"type\":\"query\"}],\"datasource\":{\"name\":\"Expression\",\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"hide\":false,\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      summary = "When alert is active, Low Disk Space on {{ $labels.instance }} (Volume: {{ $labels.mountpoint }})"
      description = "When alert is active, disk space on volume {{ $labels.mountpoint }} of instance {{ $labels.instance }} is above 85%. Current used space is {{ index .Values \"A\" }}%. If needed, take action to free up space."
    }
    labels = {
      "alert_type" = "disk"
    }
  }
  # Linux Memory
  rule {
    name      = "Node Memory"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"round(100 * (node_memory_MemAvailable_bytes{team=\\\"admins0005\\\",exporter_type=\\\"node\\\"}/node_memory_MemTotal_bytes{team=\\\"admins0005\\\",exporter_type=\\\"node\\\"}),0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[15],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "3m"
    is_paused      = false
    annotations = {
      summary = "When alert is active, Low Memory on {{ $labels.instance }}"
      description = "When alert is active, available memory on instance {{ $labels.instance }} is below 15%. Current available memory is {{ index .Values \"A\"}}%. If needed, investigate the cause."
    }
    labels = {
      "alert_type" = "memory"
    }
  }
  # Linux CPU
  rule {
    name      = "Node CPU"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"round((1 - avg(irate(node_cpu_seconds_total{mode=\\\"idle\\\",team=\\\"admins0005\\\"}[2m])) by (instance,team)) * 100,0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[80,0],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[]},\"reducer\":{\"params\":[],\"type\":\"avg\"},\"type\":\"query\"}],\"datasource\":{\"name\":\"Expression\",\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "Alerting"
    exec_err_state = "Error"
    for            = "1m"
    annotations = {
      __dashboardUid__ = grafana_dashboard.Node_Exporter_Dashboard_admins0005.uid
      __panelId__      = "20"
      summary         = "When alert is active, High CPU Usage on {{ $labels.instance }}"
      description     = "When alert is active, CPU usage on instance {{ $labels.instance }} is above 80%. Current load is {{ index .Values \"A\" }}%. If needed, investigate the cause."
    }
    labels = {
      alert_type = "CPU"
    }
    is_paused = false
  }
}
# team = admins0006
resource "grafana_rule_group" "rule_group_admins0006" {
  //org_id           = 1
  name             = "admins0006 AlertGroup"
  folder_uid       = grafana_folder.admins0006_Alerts.uid
  interval_seconds = 300

  # website text search
  # company site
  rule {
    name      = "Company site text search"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"probe_success{job=\\\"blackbox_https_texts\\\", module=\\\"https_text_company\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "OK"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      summary = "When alert is active, text search on Company Greek Website failed"
      description = "When alert is active, text search on Company Greek website is not successful. If needed, check the website or the monitoring configuration."
    }
    labels = {
      "alert_type" = "content"
    }
  }

  # service alerts
  # service MSSQLSERVER
  rule {
    name      = "MSSQL Server Service"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"windows_service_state{team=\\\"admins0006\\\", name=\\\"MSSQLSERVER\\\",state=\\\"running\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "OK"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      summary = "When alert is active, MSSQL Server Service is not running"
      description = "When alert is active, MSSQL service on {{ $labels.instance }} is not running. If needed, check the service status."
    }
    labels = {
      "alert_type" = "service"
    }
  }
  # Service MSSQL Server Agent
  rule {
    name      = "MSSQL Server Agent Service"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"windows_service_state{team=\\\"admins0006\\\", name=\\\"SQLSERVERAGENT\\\",state=\\\"running\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "OK"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      summary = "When alert is active, MSSQL Server Agent Service is not running"
      description = "When alert is active, SQLSERVERAGENT service on {{ $labels.instance }} is not running. If needed, check the service status."
    }
    labels = {
      "alert_type" = "service"
    }
  }
  # Service IIS
  rule {
    name      = "IIS Service"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"windows_service_state{team=\\\"admins0006\\\", name=\\\"W3SVC\\\",state=\\\"running\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "OK"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      summary = "When alert is active, IIS Service is not running"
      description = "When alert is active, IIS service on {{ $labels.instance }} is not running. If needed, check the service status."
    }
    labels = {
      "alert_type" = "service"
    }
  }

  # server down
  rule {
    name      = "WindowsInstanceDown"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"up{team=\\\"admins0006\\\",exporter_type=\\\"winexporter\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      summary = "When alert is active, Windows instance {{ $labels.instance }} is down"
      description = "When alert is active, Windows instance {{ $labels.instance }} is not reachable. If needed, check the server status."
    }
    labels = {
      "alert_type" = "instance"
    }
  }
  # disk space
  rule {
    name      = "WindowsHardDiskVolumeWarning"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"round(100-(windows_logical_disk_free_bytes{team=\\\"admins0006\\\",exporter_type=\\\"winexporter\\\", volume!~\\\".*Harddisk.*\\\"}/windows_logical_disk_size_bytes{team=\\\"admins0006\\\",exporter_type=\\\"winexporter\\\", volume!~\\\".*Harddisk.*\\\"}) * 100,0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[85],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      __dashboardUid__ = grafana_dashboard.Windows_Exporter_Dashboard_2024_admins0006.uid
      __panelId__     = "23"
      summary = "When alert is active, Windows disk space is above 85% on {{ $labels.instance }} (volume: {{ $labels.volume }})"
      description = "When alert is active, disk space on volume {{ $labels.volume }} of instance {{ $labels.instance }} is above 85%. Current used space is {{ index .Values \"A\" }}%. If needed, take action to free up space."
    }
    labels = {
      "alert_type" = "disk"
    }
  }
  # CPU usage
  rule {
    name      = "WindowsCPUPercWarning"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"round((1 - irate(windows_cpu_time_total{team=\\\"admins0006\\\",exporter_type=\\\"winexporter\\\",mode=\\\"idle\\\"}[5m])) * 100,0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[90],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      __dashboardUid__ = grafana_dashboard.Windows_Exporter_Dashboard_2024_admins0006.uid
      __panelId__     = "19"
      summary = "When alert is active, Windows CPU usage is above 90% on {{ $labels.instance }}"
      description = "When alert is active, CPU usage on instance {{ $labels.instance }} is above 90%. Current load is {{ index .Values \"A\" }}%. If needed, investigate the cause."
    }
    labels = {
      "alert_type" = "cpu"
    }
  }
  # Windows Memory normal
  rule {
    name      = "Windows Memory normal"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"round(100 * (windows_os_physical_memory_free_bytes{team=\\\"admins0006\\\",mem=\\\"normal\\\"}/windows_cs_physical_memory_bytes{team=\\\"admins0006\\\",mem=\\\"normal\\\"}),0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[5],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "3m"
    is_paused      = false
    annotations = {
      __dashboardUid__ = grafana_dashboard.Windows_Exporter_Dashboard_2024_admins0006.uid
      __panelId__     = "21"
      summary = "When alert is active, Windows Memory is below 5% on {{ $labels.instance }}"
      description = "When alert is active, available Memory on instance {{ $labels.instance }} is below 5%. Current available memory is {{ index .Values \"A\" }}%. If needed, investigate the cause."
    }
    labels = {
      "alert_type" = "memory"
    }
  }
    # Windows Memory high
  rule {
    name      = "Windows Memory high"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"round(100 * (windows_os_physical_memory_free_bytes{team=\\\"admins0006\\\",mem=\\\"high\\\"}/windows_cs_physical_memory_bytes{team=\\\"admins0006\\\",mem=\\\"high\\\"}),0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[2],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "3m"
    is_paused      = false
    annotations = {
      __dashboardUid__ = grafana_dashboard.Windows_Exporter_Dashboard_2024_admins0006.uid
      __panelId__     = "21"
      summary = "When alert is active, Windows Memory is below 2% on {{ $labels.instance }}"
      description = "When alert is active, available Memory on instance {{ $labels.instance }} is below 2%. Current available memory is {{ index .Values \"A\" }}%. If needed, investigate the cause."
    }
    labels = {
      "alert_type" = "memory"
    }
  }
}
# team = admins0007
resource "grafana_rule_group" "rule_group_admins0007" {
  org_id           = 1
  name             = "admins0007 Alertgroups"
  folder_uid       = grafana_folder.admins0007_Alerts.uid
  interval_seconds = 60

  rule {
    name      = "server1_rest API Status"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"probe_http_status_code{team=\\\"admins0007\\\",job=\\\"blackbox_server1_rest_api\\\", instance=\\\"server1\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[0,0],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[]},\"reducer\":{\"params\":[],\"type\":\"avg\"},\"type\":\"query\"}],\"datasource\":{\"name\":\"Expression\",\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"$A!=200\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"math\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "2m"
    is_paused      = false
    annotations = {
      summary     = "When alert is active, server1_rest API is down on {{ $labels.instance }}"
      description = "When alert is active, server1_rest API on instance {{ $labels.instance }} is not returning status code 200 or correct path. If needed, check the API status."
    }
    labels = {
      "alert_type" = "API_status"
    }
  }
}
# team = admins0008
resource "grafana_rule_group" "rule_group_admins0008" {
  org_id           = 1
  name             = "admins0008 Alertgroups"
  folder_uid       = grafana_folder.admins0008_Alerts.uid
  interval_seconds = 60

  # server2 ICMP-Ping Check
  rule {
    name      = "server2 ICMP-Ping Check"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"exemplar\":false,\"expr\":\"probe_success{team=\\\"admins0008\\\",job=\\\"blackbox_icmp\\\", instance=\\\"server2.bankofgreece.gr\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "1m"
    is_paused      = false
    annotations = {
      summary     = "When alert is active, ICMP Ping to {{ $labels.instance }} has failed"
      description = "When alert is active, the ICMP Ping to {{ $labels.instance }} is failing. If needed, check the server status."
    }
    labels = {
      "alert_type" = "icmp_ping"
    }
  }
  # server2 DNS from dc1
  rule {
    name      = "server2 DNS from dc1"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"exemplar\":false,\"expr\":\"probe_dns_query_succeeded{team=\\\"admins0008\\\",job=\\\"blackbox_dns_admins0008\\\", instance=\\\"server2\\\",dnsserver=\\\"10.10.10.10\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "1m"
    is_paused      = false
    annotations = {
      summary     = "When alert is active, DNS query from dc1 DNS Server has failed for {{ $labels.instance }}"
      description = "When alert is active, the DNS query from dc1 (DNS Server=10.10.10.10) for instance {{ $labels.instance }} is failing. If needed, check the DNS resolution."
    }
    labels = {
      "alert_type" = "dns"
    }
  }
  # server2 DNS from dc2
  rule {
    name      = "server2 DNS from dc2"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"exemplar\":false,\"expr\":\"probe_dns_query_succeeded{team=\\\"admins0008\\\",job=\\\"blackbox_dns_admins0008\\\", instance=\\\"server2\\\",dnsserver=\\\"10.10.10.11\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "1m"
    is_paused      = false
    annotations = {
      summary     = "When alert is active, DNS query from dc2 DNS Server has failed for {{ $labels.instance }}"
      description = "When alert is active, The DNS query from dc2 (DNS Server=10.10.10.11) for instance {{ $labels.instance }} is failing. If needed, check the DNS resolution."
    }
    labels = {
      "alert_type" = "dns"
    }
  }
  # server1 ICMP-Ping Check
  rule {
    name      = "server1 ICMP-Ping Check"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"exemplar\":false,\"expr\":\"probe_success{team=\\\"admins0008\\\",job=\\\"blackbox_icmp\\\", instance=\\\"server1.bankofgreece.gr\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "1m"
    is_paused      = false
    annotations = {
      summary     = "When alert is active, ICMP Ping to {{ $labels.instance }} has failed"
      description = "When alert is active, the ICMP Ping to {{ $labels.instance }} is failing. If needed, check the server status."
    }
    labels = {
      "alert_type" = "icmp_ping"
    }
  }
  # server1 DNS from dc1
  rule {
    name      = "server1 DNS from dc1"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"exemplar\":false,\"expr\":\"probe_dns_query_succeeded{team=\\\"admins0008\\\",job=\\\"blackbox_dns_admins0008\\\", instance=\\\"server1\\\",dnsserver=\\\"10.10.10.10\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "1m"
    is_paused      = false
    annotations = {
      summary     = "When alert is active, DNS query from dc1 DNS Server has failed for {{ $labels.instance }}"
      description = "When alert is active, the DNS query from dc1 (DNS Server=10.10.10.10) for instance {{ $labels.instance }} is failing. If needed, check the DNS resolution."
    }
    labels = {
      "alert_type" = "dns"
    }
  }
  # server1 DNS from dc2
  rule {
    name      = "server1 DNS from dc2"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"exemplar\":false,\"expr\":\"probe_dns_query_succeeded{team=\\\"admins0008\\\",job=\\\"blackbox_dns_admins0008\\\", instance=\\\"server1\\\",dnsserver=\\\"10.10.10.11\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "1m"
    is_paused      = false
    annotations = {
      summary     = "When alert is active, DNS query from dc2 DNS Server has failed for {{ $labels.instance }}"
      description = "When alert is active, the DNS query from dc2 (DNS Server=10.10.10.11) for instance {{ $labels.instance }} is failing. If needed, check the DNS resolution."
    }
    labels = {
      "alert_type" = "dns"
    }
  }  
}
# team = admins0009
resource "grafana_rule_group" "rule_group_admins0009" {
  //org_id           = 1
  name             = "admins0009 AlertGroup"
  folder_uid       = grafana_folder.admins0009_Alerts.uid
  interval_seconds = 300

  # Server down
  rule {
    name      = "WindowsInstanceDown"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"up{team=\\\"admins0009\\\",exporter_type=\\\"winexporter\\\"}\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[1],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      summary = "When alert is active, Windows instance {{ $labels.instance }} is down"
      description = "When alert is active,  Windows instance {{ $labels.instance }} is not reachable. If needed, check the server status."
    }
    labels = {
      "alert_type" = "instance"
    }
  }
  # disk space
  rule {
    name      = "WindowsHardDiskVolumeWarning"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"round(100-(windows_logical_disk_free_bytes{team=\\\"admins0009\\\",exporter_type=\\\"winexporter\\\", volume!~\\\".*Harddisk.*\\\"}/windows_logical_disk_size_bytes{team=\\\"admins0009\\\",exporter_type=\\\"winexporter\\\", volume!~\\\".*Harddisk.*\\\"}) * 100,0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[85],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      __dashboardUid__ = grafana_dashboard.Windows_Exporter_Dashboard_2024_admins0009.uid
      __panelId__     = "23"
      summary = "When alert is active, Windows disk space is above 85% on {{ $labels.instance }} (volume: {{ $labels.volume }})"
      description = "When alert is active, disk space on volume {{ $labels.volume }} of instance {{ $labels.instance }} is above 85%. Current used space is {{ index .Values \"A\" }}%. If needed, take action to free up space."
    }
    labels = {
      "alert_type" = "disk"
    }
  }
  # CPU usage
  rule {
    name      = "WindowsCPUPercWarning"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"round((1 - irate(windows_cpu_time_total{team=\\\"admins0009\\\",exporter_type=\\\"winexporter\\\",mode=\\\"idle\\\"}[5m])) * 100,0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[85],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "5m"
    is_paused      = false
    annotations = {
      __dashboardUid__ = grafana_dashboard.Windows_Exporter_Dashboard_2024_admins0009.uid
      __panelId__     = "19"
      summary = "When alert is active, Windows CPU usage is above 85% on {{ $labels.instance }}"
      description = "When alert is active, CPU usage on instance {{ $labels.instance }} is above 85%. Current load is {{ index .Values \"A\" }}%. If needed, investigate the cause."
    }
    labels = {
      "alert_type" = "cpu"
    }
  }
  # Windows Memory
  rule {
    name      = "Windows Memory"
    condition = "B"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = grafana_data_source.prometheus.uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"round(100 * (windows_os_physical_memory_free_bytes{team=\\\"admins0009\\\",exporter_type=\\\"winexporter\\\"}/windows_cs_physical_memory_bytes{team=\\\"admins0009\\\",exporter_type=\\\"winexporter\\\"}),0.01)\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[15],\"type\":\"lt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"B\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "3m"
    is_paused      = false
    annotations = {
      __dashboardUid__ = grafana_dashboard.Windows_Exporter_Dashboard_2024_admins0009.uid
      __panelId__     = "21"
      summary = "When alert is active, Windows Memory is below 15% on {{ $labels.instance }}"
      description = "When alert is active, the available memory on instance {{ $labels.instance }} is below 15%. Current available memory is {{ index .Values \"A\" }}%. If needed, investigate the cause."
    }
    labels = {
      "alert_type" = "memory"
    }
  }
}