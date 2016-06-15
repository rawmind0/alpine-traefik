#!/usr/bin/env bash

function log {
        echo `date` $ME - $@
}

function serviceLog {
    log "[ Redirecting ${SERVICE_NAME} log... ]"
    if [ -e ${TRAEFIK_LOG_FILE} ]; then
        rm ${TRAEFIK_LOG_FILE}
    fi
    ln -sf /proc/1/fd/1 ${TRAEFIK_LOG_FILE}
}

function serviceCheck {
    log "[ Generating ${SERVICE_NAME} configuration... ]"
    ${SERVICE_HOME}/bin/traefik.toml.sh
}

function serviceSsl {
    if [ ${TRAEFIK_SSL_KEY} -ne "" ]
        log "[ Configuring ${SERVICE_NAME} ssl key and cert... ]"
        ${SERVICE_HOME}/bin/traefik.toml.sh
    fi
}

function serviceStart {
    serviceCheck
    log "[ Starting ${SERVICE_NAME}... ]"
    nohup ${SERVICE_HOME}/bin/traefik --configFile=${SERVICE_HOME}/etc/traefik.toml &
}

function serviceStop {
    log "[ Stoping ${SERVICE_NAME}... ]"
    killall traefik
}

function serviceRestart {
    log "[ Restarting ${SERVICE_NAME}... ]"
    serviceStop
    serviceStart
}

export TRAEFIK_ENTRYPOINTS=${TRAEFIK_ENTRYPOINTS:-'"http"'}
export TRAEFIK_HTTP_PORT=${TRAEFIK_HTTP_PORT:-"8080"}
export TRAEFIK_HTTPS_PORT=${TRAEFIK_HTTPS_PORT:-"8443"}
export TRAEFIK_ADMIN_PORT=${TRAEFIK_ADMIN_PORT:-"8000"}
export TRAEFIK_LOG_LEVEL=${TRAEFIK_LOG_LEVEL:-"INFO"}
export TRAEFIK_LOG_FILE=${TRAEFIK_LOG_FILE:-"${SERVICE_HOME}/log/traefik.log"}
export TRAEFIK_SSL_PATH=${TRAEFIK_SSL_PATH:-"${SERVICE_HOME}/certs"}


export TRAEFIK_HTTP_PORT TRAEFIK_HTTPS_PORT TRAEFIK_ADMIN_PORT TRAEFIK_LOG_FILE TRAEFIK_LOG_LEVEL

case "$1" in
        "start")
            serviceLog
            serviceStart
        ;;
        "stop")
            serviceStop
        ;;
        "restart")
            serviceRestart
        ;;
        *) echo "Usage: $0 restart|start|stop"
        ;;

esac
