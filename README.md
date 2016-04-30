alpine-traefik
==============

This image is the traefik base. It comes from rawmind/alpine-monit.

## Build

```
docker build -t rawmind/alpine-traefik:<version> .
```

## Versions

- `1.0.0-beta.555` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/master/Dockerfile)


## Usage

This image runs [traefik][traefik] with monit. Traefik is installed under /opt/traefik and make use of /opt/traefik/etc/traefik.toml and /opt/traefik/etc/rules.toml. Http service is available at ${TRAEFIK_HTTP_PORT} and you could add frontend's and backend's throught the traefik rest-api available at ${TRAEFIK_ADMIN_PORT}. 

If you are running it in rancher, you could run [rancher-traefik][rancher-traefik] as a sidekick to get dynamic configuration. 

You could also include `FROM rawmind/alpine-traefik` at the top of your `Dockerfile`, and add your custom config. 


## Default parameters

These are the default parameters to run traefik. You could overwrite these values, setting environment variables.

TRAEFIK_HTTP_PORT=${TRAEFIK_HTTP_PORT:-"8080"}
TRAEFIK_ADMIN_PORT=${TRAEFIK_ADMIN_PORT:-"8000"}


## Example

See [rancher-example][rancher-example], that run a traefik lb in all infrastructure servers and publish ${TRAEFIK_HTTP_PORT} and ${TRAEFIK_ADMIN_PORT} throught them.


## TODO

Add https automation to the docker.


[traefik]: https://github.com/containous/traefik
[rancher-traefik]: https://hub.docker.com/r/rawmind/rancher-traefik/
[rancher-example]: https://github.com/rawmind0/alpine-traefik/rancher
