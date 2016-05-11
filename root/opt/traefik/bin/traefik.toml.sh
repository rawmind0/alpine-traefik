#!/usr/bin/env sh

cat << EOF > ${SERVICE_HOME}/etc/traefik.toml
# traefik.toml
logLevel = "INFO"
traefikLogsFile = "/opt/traefik/log/traefik.log"
accessLogsFile = "/opt/traefik/log/access.log"
defaultEntryPoints = ["http"]
[entryPoints]
  [entryPoints.http]
  address = ":${TRAEFIK_HTTP_PORT}"
[web]
address = ":${TRAEFIK_ADMIN_PORT}"

[file]
filename = "/opt/traefik/etc/rules.toml"
watch = true
EOF
