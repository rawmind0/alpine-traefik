#!/usr/bin/env sh

# Check that you provide key/crt files and add them to the config
filelist=`ls -1 ${TRAEFIK_SSL_PATH}/*.key | cut -d"." -f1`
RC=`echo $?`

if [ $RC -eq 0 ]; then
    TRAEFIK_SSL_OPTS="\
  [entryPoints.https]
  address = \":${TRAEFIK_HTTPS_PORT}\"
    [entryPoints.https.tls]"
    for i in $filelist; do
        if [ -f "$i.crt" ]; then
            TRAEFIK_SSL_OPTS=$TRAEFIK_SSL_OPTS"
      [[entryPoints.https.tls.certificates]]
      certFile = \"${i}.crt\"
      keyFile = \"${i}.key\""
        fi
    done
    TRAEFIK_ENTRYPOINTS='"http", "https"'
fi


cat << EOF > ${SERVICE_HOME}/etc/traefik.toml
# traefik.toml
logLevel = "${TRAEFIK_LOG_LEVEL}"
traefikLogsFile = "${TRAEFIK_LOG_FILE}"
accessLogsFile = "${SERVICE_HOME}/log/access.log"
defaultEntryPoints = [${TRAEFIK_ENTRYPOINTS}]
[entryPoints]
  [entryPoints.http]
  address = ":${TRAEFIK_HTTP_PORT}"
  ${TRAEFIK_SSL_OPTS}
[web]
address = ":${TRAEFIK_ADMIN_PORT}"

[file]
filename = "${SERVICE_HOME}/etc/rules.toml"
watch = true
EOF
