FROM rawmind/alpine-monit:0.3.3-2
MAINTAINER Raul Sanchez <rawmind@gmail.com>

#Set environment
ENV SERVICE_NAME=traefik \
    SERVICE_HOME=/opt/traefik \
    SERVICE_VERSION=v1.0.0-beta.771 \
    SERVICE_URL=https://github.com/containous/traefik/releases/download
ENV SERVICE_RELEASE=${SERVICE_URL}/${SERVICE_VERSION}/traefik_linux-amd64 \
    PATH=${PATH}:${SERVICE_HOME}/bin 

# Download and install traefik
RUN mkdir -p ${SERVICE_HOME}/bin ${SERVICE_HOME}/etc ${SERVICE_HOME}/log \
  && cd ${SERVICE_HOME}/bin \
  && curl -jksSL "${SERVICE_RELEASE}" -O \
  && mv traefik_linux-amd64 traefik \
  && chmod +x ${SERVICE_HOME}/bin/traefik 
ADD root /
RUN chmod +x ${SERVICE_HOME}/bin/*.sh 

USER $SERVICE_USER
WORKDIR $SERVICE_HOME

EXPOSE 8000 8080 8443
