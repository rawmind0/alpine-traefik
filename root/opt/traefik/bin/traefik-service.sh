#!/usr/bin/env bash

function log {
        echo `date` $ME - $@
}

function serviceCheck {
    log "[ Generating ${SERVICE_NAME} configuration... ]"

}

function serviceStart {
    log "[ Starting ${SERVICE_NAME}... ]"
    nohup ${SERVICE_HOME}/bin/traefik --configFile ${SERVICE_HOME}/etc/traefik.toml &
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

case "$1" in
        "start")
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
