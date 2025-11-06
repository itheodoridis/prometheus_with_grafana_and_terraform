resource "grafana_message_template" "ops_email" {
  name = "ops-email"
  template = <<-EOT
{{/* ===== SUBJECT ===== */}}
{{ define "email.title" -}}
{{ $type := index .CommonLabels "alert_type" }}
Prometheus: {{ if .Alerts.Firing }}[{{ len .Alerts.Firing }} firing]{{end}}{{ if .Alerts.Resolved }} [{{ len .Alerts.Resolved }} resolved]{{ end }}
{{- if eq $type "disk" }} DISK ISSUE:
{{- else if eq $type "cpu" }} CPU ISSUE:
{{- else if eq $type "memory" }} MEMORY ISSUE:
{{- else if eq $type "service" }} SERVICE ISSUE:
{{- else if eq $type "content" }} CONTENT CHECK ISSUE:
{{- else if eq $type "dns" }} DNS ISSUE:
{{- else if eq $type "icmp_ping" }} HOST REACHABILITY ISSUE:
{{- else if eq $type "instance" }} HOST DOWN:
{{- else if eq $type "API_status" }} API STATUS ISSUE:
{{- end }}
 {{ .CommonLabels.alertname }}{{ if .CommonLabels.grafana_folder }} — {{ .CommonLabels.grafana_folder }}{{ end }}
{{- end }}

{{/* ===== BODY ===== */}}
{{- define "email.message" -}}
{{- $type := index .CommonLabels "alert_type" -}}
{{- if .GroupLabels }}Group: {{ range (.GroupLabels.SortedPairs) }}{{ .Name }}={{ .Value }} {{ end }}
{{- end }}

{{- if eq $type "disk" }}Disk capacity condition detected.
{{- else if eq $type "cpu" }}CPU usage condition detected.
{{- else if eq $type "memory" }}Memory pressure condition detected.
{{- else if eq $type "service" }}Service health condition detected.
{{- else if eq $type "content" }}Content check failed.
{{- else if eq $type "dns" }}DNS condition detected.
{{- else if eq $type "icmp_ping" }}Host reachability condition detected.
{{- else if eq $type "instance" }}Host is down or unreachable.
{{- else if eq $type "API_status" }}API status condition detected.
{{- else }}Alert: {{ .CommonLabels.alertname }}
{{- end }}

{{- if .Alerts.Firing }}
============================================================================
FIRING ({{ len .Alerts.Firing }}):
{{- range .Alerts.Firing }}
- INSTANCE: {{ index .Labels "instance" }}{{ if (index .Labels "volume") }} | VOLUME {{ index .Labels "volume" }}{{ end }}{{ if (index .Labels "mountpoint") }} | mount {{ index .Labels "mountpoint" }}{{ end }}
  A={{ with (index .Values "A") }}{{ printf "%.2f" . }}{{ else }}n/a{{ end }}
  Silence: {{ .SilenceURL }}
  Labels:
  {{- range (.Labels.SortedPairs) }}
  - {{ .Name }} = {{ .Value }}
  {{- end }}
----------------------------------------------------------------------------
{{- end }}
{{- end }}

{{- if .Alerts.Resolved }}
============================================================================
RESOLVED ({{ len .Alerts.Resolved }}):
{{- range .Alerts.Resolved }}
- INSTANCE: {{ index .Labels "instance" }} / {{ if (index .Labels "volume") }} | VOLUME {{ index .Labels "volume" }}{{ end }}{{ if (index .Labels "mountpoint") }} | mount {{ index .Labels "mountpoint" }}{{ end }}
  A={{ with (index .Values "A") }}{{ printf "%.2f" . }}{{ else }}n/a{{ end }}
  Silence: {{ .SilenceURL }}
  Labels:
  {{- range (.Labels.SortedPairs) }}
  - {{ .Name }} = {{ .Value }}
  {{- end }}
----------------------------------------------------------------------------
{{- end }}
{{- end }}

{{- if or .Alerts.Firing .Alerts.Resolved }}
{{- $a := (index (or .Alerts.Firing .Alerts.Resolved) 0) }}
Links:
{{- if $a.PanelURL }}- Panel: {{ $a.PanelURL }}
{{- end }}
{{- if $a.DashboardURL }}- Dashboard: {{ $a.DashboardURL }}
{{- end }}
{{- if $a.SilenceURL }}
- Silence: {{ $a.SilenceURL }}
{{- end }}
{{- if $a.GeneratorURL }}
- Alert Source: {{ $a.GeneratorURL }}
{{- end }}
{{- end }}
{{- end }}
EOT
}
