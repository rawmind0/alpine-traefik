[![](https://images.microbadger.com/badges/image/rawmind/alpine-traefik.svg)](https://microbadger.com/images/rawmind/alpine-traefik "Get your own image badge on microbadger.com")

alpine-traefik 
==============

This image is the traefik base. It comes from [alpine-monit][alpine-monit].

## Build

```
docker build -t rawmind/alpine-traefik:<version> .
```

## Versions

- `1.0.2-6` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.0.2-6/Dockerfile)
- `1.0.1-4` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.0.1-4/Dockerfile)
- `1.0.0` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.0.0/Dockerfile)
- `1.0.0-rc3-3` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.0.0-rc3-3/Dockerfile)
- `1.0.0-rc2-6` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.0.0-rc2-6/Dockerfile)
- `1.0.0-beta.771` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.0.0-beta.771/Dockerfile)
- `1.0.0-beta.555-6` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.0.0-beta.555-6/Dockerfile)


## Configuration

This image runs [traefik][traefik] with monit. It is started with traefik user/group with 10001 uid/gid.

Besides, you can customize the configuration in several ways:

### Default Configuration

Traefic is installed with the default configuration and some parameters can be overrided with env variables:

- TRAEFIK_HTTP_PORT=8080								# http port > 1024 due to run as non privileged user
- TRAEFIK_HTTPS_ENABLE="false"							# "true" enables https and http endpoints. "Only" enables https endpoints and redirect http to https.
- TRAEFIK_HTTPS_PORT=8443								# https port > 1024 due to run as non privileged user
- TRAEFIK_ADMIN_PORT=8000								# admin port > 1024 due to run as non privileged user
- TRAEFIK_LOG_LEVEL="INFO"								# Log level
- TRAEFIK_LOG_FILE="/opt/traefik/log/traefik.log"}		# Log file. Redirected to docker stdout.
- TRAEFIK_ACCESS_FILE="/opt/traefik/log/access.log"}	# Access file. Redirected to docker stdout.
- TRAEFIK_SSL_PATH="/opt/traefik/certs"					# Path to search .key and .crt files
- TRAEFIK_ACME_ENABLE="false"							# Enable/disable traefik ACME feature
- TRAEFIK_ACME_EMAIL="test@traefik.io"					# Default email
- TRAEFIK_ACME_ONDEMAND="true"							# ACME ondemand parameter

### Custom Configuration

Traefik is installed under /opt/traefik and make use of /opt/traefik/etc/traefik.toml and /opt/traefik/etc/rules.toml.

You can edit or overwrite this files in order to customize your own configuration or certificates.

You could also include FROM rawmind/alpine-traefik at the top of your Dockerfile, and add your custom config.

### SSL Configuration

Added SSL configuration. Set TRAEFIK_HTTPS_ENABLE="< true || only >" to enable it. 

SSL certificates are located by default in /opt/traefik/certs. You need to provide .key AND .crt files to that directory, in order traefik gets automatically configured with ssl.

If you put more that one key/crt files in the certs directory, traefik gets sni enabled and configured. You also could map you cert storage volume to traefik and mount it in $TRAEFIK_SSL_PATH value.

You could also include FROM rawmind/alpine-traefik at the top of your Dockerfile, and add your custom ssl files.

### Letsencrypt Configuration

If you enable SSL configuration, you could enable traefik letsencrypt support as well (ACME). To do it, set TRAEFIK_ACME_ENABLE="true".


### Rancher

If you are running it in rancher, you could run [rancher-traefik][rancher-traefik] as a sidekick to get dynamic configuration.


## Example

See [rancher-example][rancher-example], that run a traefik lb in all infrastructure servers and publish ${TRAEFIK_HTTP_PORT}, ${TRAEFIK_HTTPS_PORT} and ${TRAEFIK_ADMIN_PORT} throught them.


## TODO

Add sni automation to the traefik.

[alpine-monit]: https://github.com/rawmind0/alpine-monit/
[traefik]: https://github.com/containous/traefik
[rancher-traefik]: https://hub.docker.com/r/rawmind/rancher-traefik/
[rancher-example]: https://github.com/rawmind0/alpine-traefik/tree/master/rancher
