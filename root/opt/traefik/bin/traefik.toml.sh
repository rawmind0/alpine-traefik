#!/usr/bin/env sh

TRAEFIK_ENTRYPOINTS_HTTP="\
  [entryPoints.http]
  address = \":${TRAEFIK_HTTP_PORT}\"\

"

# Check that you provide key/crt files and add them to the config
filelist=`ls -1 ${TRAEFIK_SSL_PATH}/*.key | cut -d"." -f1`
RC=`echo $?`

if [ $RC -eq 0 ]; then
    TRAEFIK_ENTRYPOINTS_HTTPS="\
  [entryPoints.https]
  address = \":${TRAEFIK_HTTPS_PORT}\"
    [entryPoints.https.tls]"
    for i in $filelist; do
        if [ -f "$i.crt" ]; then
            TRAEFIK_ENTRYPOINTS_HTTPS=$TRAEFIK_ENTRYPOINTS_HTTPS"
      [[entryPoints.https.tls.certificates]]
      certFile = \"${i}.crt\"
      keyFile = \"${i}.key\""
        fi
    done
fi

if [ "X${TRAEFIK_HTTPS_ENABLE}" == "Xtrue" ]; then
    TRAEFIK_ENTRYPOINTS_OPTS=${TRAEFIK_ENTRYPOINTS_HTTP}${TRAEFIK_ENTRYPOINTS_HTTPS}
    TRAEFIK_ENTRYPOINTS='"http", "https"'
elif [ "X${TRAEFIK_HTTPS_ENABLE}" == "Xonly" ]; then
    TRAEFIK_ENTRYPOINTS_OPTS=${TRAEFIK_ENTRYPOINTS_HTTPS}
    TRAEFIK_ENTRYPOINTS='"https"'
else 
    TRAEFIK_ENTRYPOINTS_OPTS=${TRAEFIK_ENTRYPOINTS_HTTP}
    TRAEFIK_ENTRYPOINTS='"http"'
fi

TRAEFIK_ACME_CFG=""
if [ "X${TRAEFIK_HTTPS_ENABLE}" == "Xtrue" ] || [ "X${TRAEFIK_HTTPS_ENABLE}" == "Xonly" ] && [ "X${TRAEFIK_ACME_ENABLE}" == "Xtrue" ]; then

    TRAEFIK_ACME_CFG="\
[acme]
email = \"${TRAEFIK_ACME_EMAIL}\"
storageFile = \"${SERVICE_HOME}/acme/acme.json\"
onDemand = ${TRAEFIK_ACME_ONDEMAND}
entryPoint = \"https\"

"

fi


cat << EOF > ${SERVICE_HOME}/etc/traefik.toml
# traefik.toml
logLevel = "${TRAEFIK_LOG_LEVEL}"
traefikLogsFile = "${TRAEFIK_LOG_FILE}"
accessLogsFile = "${TRAEFIK_ACCESS_FILE}"
defaultEntryPoints = [${TRAEFIK_ENTRYPOINTS}]
[entryPoints]
${TRAEFIK_ENTRYPOINTS_OPTS}
[web]
address = ":${TRAEFIK_ADMIN_PORT}"

[file]
filename = "${SERVICE_HOME}/etc/rules.toml"
watch = true

${TRAEFIK_ACME_CFG}
EOF
