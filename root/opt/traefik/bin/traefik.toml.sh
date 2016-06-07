#!/usr/bin/env sh

cat << EOF > ${SERVICE_HOME}/etc/traefik.toml
# traefik.toml
logLevel = "INFO"
traefikLogsFile = "/opt/traefik/log/traefik.log"
accessLogsFile = "/opt/traefik/log/access.log"
defaultEntryPoints = ["http", "https"]
[entryPoints]
  [entryPoints.http]
  address = ":${TRAEFIK_HTTP_PORT}"
  [entryPoints.https]
  address = ":${TRAEFIK_HTTPS_PORT}"
    [entryPoints.https.tls]
      [[entryPoints.https.tls.certificates]]
      certFile = "/opt/traefik/certs/traefik.crt"
      keyFile = "/opt/traefik/certs/traefik.key"
[web]
address = ":${TRAEFIK_ADMIN_PORT}"

[file]
filename = "/opt/traefik/etc/rules.toml"
watch = true
EOF
