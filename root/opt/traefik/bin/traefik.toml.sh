#!/usr/bin/env sh

TRAEFIK_HTTP_PORT=${TRAEFIK_HTTP_PORT:-"8080"}
TRAEFIK_HTTPS_ENABLE=${TRAEFIK_HTTPS_ENABLE:-"false"}
TRAEFIK_HTTPS_PORT=${TRAEFIK_HTTPS_PORT:-"8443"}
TRAEFIK_ADMIN_PORT=${TRAEFIK_ADMIN_PORT:-"8000"}
TRAEFIK_LOG_LEVEL=${TRAEFIK_LOG_LEVEL:-"INFO"}
TRAEFIK_LOG_FILE=${TRAEFIK_LOG_FILE:-"${SERVICE_HOME}/log/traefik.log"}
TRAEFIK_ACCESS_FILE=${TRAEFIK_ACCESS_FILE:-"${SERVICE_HOME}/log/access.log"}
TRAEFIK_SSL_PATH=${TRAEFIK_SSL_PATH:-"${SERVICE_HOME}/certs"}
TRAEFIK_ACME_ENABLE=${TRAEFIK_ACME_ENABLE:-"false"}
TRAEFIK_ACME_EMAIL=${TRAEFIK_ACME_EMAIL:-"test@traefik.io"}
TRAEFIK_ACME_ONDEMAND=${TRAEFIK_ACME_ONDEMAND:-"true"}

TRAEFIK_ENTRYPOINTS_HTTP="\
  [entryPoints.http]
  address = \":${TRAEFIK_HTTP_PORT}\"
"

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
      keyFile = \"${i}.key\"
"
        fi
    done
fi

if [ "X${TRAEFIK_HTTPS_ENABLE}" == "Xtrue" ]; then
    TRAEFIK_ENTRYPOINTS_OPTS=${TRAEFIK_ENTRYPOINTS_HTTP}${TRAEFIK_ENTRYPOINTS_HTTPS}
    TRAEFIK_ENTRYPOINTS='"http", "https"'
elif [ "X${TRAEFIK_HTTPS_ENABLE}" == "Xonly" ]; then
    TRAEFIK_ENTRYPOINTS_HTTP=$TRAEFIK_ENTRYPOINTS_HTTP"\
    [entryPoints.http.redirect]
       entryPoint = \"https\"
"
    TRAEFIK_ENTRYPOINTS_OPTS=${TRAEFIK_ENTRYPOINTS_HTTP}${TRAEFIK_ENTRYPOINTS_HTTPS}
    TRAEFIK_ENTRYPOINTS='"http", "https"'
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
