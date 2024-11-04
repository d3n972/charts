{{/*
Expand the name of the chart.
*/}}
{{- define "nginx-reverse-proxy.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nginx-reverse-proxy.fullname" -}}
{{- printf "fqdn"| trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nginx-reverse-proxy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- define "nginx-reverse-proxy.labels" -}}
app.kubernetes.io/version: "1"
app.kubernetes.io/managed-by: "nginx-reverse-proxy"
{{- end }}
{{/*
Create the name of the service account to use
*/}}
{{- define "nginx-reverse-proxy.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default  .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
