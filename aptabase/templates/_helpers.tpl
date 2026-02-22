{{/*
Expand the name of the chart.
*/}}
{{- define "aptabase.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "aptabase.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "aptabase.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "aptabase.labels" -}}
helm.sh/chart: {{ include "aptabase.chart" . }}
{{ include "aptabase.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "aptabase.selectorLabels" -}}
app.kubernetes.io/name: {{ include "aptabase.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Component label selector
*/}}
{{- define "aptabase.componentSelectorLabels" -}}
{{ include "aptabase.selectorLabels" . }}
app.kubernetes.io/component: {{ .component }}
{{- end }}

{{/*
Component full name
*/}}
{{- define "aptabase.componentFullname" -}}
{{- printf "%s-%s" (include "aptabase.fullname" .ctx) .component | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "aptabase.appFullname" -}}
{{- include "aptabase.componentFullname" (dict "ctx" . "component" "app") -}}
{{- end }}

{{- define "aptabase.postgresFullname" -}}
{{- include "aptabase.componentFullname" (dict "ctx" . "component" "db") -}}
{{- end }}

{{- define "aptabase.clickhouseFullname" -}}
{{- include "aptabase.componentFullname" (dict "ctx" . "component" "events-db") -}}
{{- end }}

{{- define "aptabase.secretsName" -}}
{{- printf "%s-secrets" (include "aptabase.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "aptabase.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "aptabase.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
