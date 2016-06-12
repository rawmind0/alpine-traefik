#!/usr/bin/env sh

cat << EOF > ${SERVICE_HOME}/etc/traefik.toml
# traefik.toml
logLevel = "${TRAEFIK_LOG_LEVEL}"
traefikLogsFile = "${TRAEFIK_LOG_FILE}"
accessLogsFile = "${SERVICE_HOME}/log/access.log"
defaultEntryPoints = ["http", "https"]
[entryPoints]
  [entryPoints.http]
  address = ":${TRAEFIK_HTTP_PORT}"
  [entryPoints.https]
  address = ":${TRAEFIK_HTTPS_PORT}"
    [entryPoints.https.tls]
      [[entryPoints.https.tls.certificates]]
      certFile = "${SERVICE_HOME}/certs/traefik.crt"
      keyFile = "${SERVICE_HOME}/certs/traefik.key"
[web]
address = ":${TRAEFIK_ADMIN_PORT}"

[file]
filename = "${SERVICE_HOME}/etc/rules.toml"
watch = true
EOF
