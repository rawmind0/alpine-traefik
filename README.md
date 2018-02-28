[![](https://images.microbadger.com/badges/image/rawmind/alpine-traefik.svg)](https://microbadger.com/images/rawmind/alpine-traefik "Get your own image badge on microbadger.com")

alpine-traefik
==============

This image is the traefik base. It comes from [alpine-monit][alpine-monit].

## Build

```
docker build -t rawmind/alpine-traefik:<version> .
```

## Versions

- `1.5.3-0` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.5.3-0/Dockerfile)
- `1.5.2-0` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.5.2-0/Dockerfile)
- `1.5.1-0` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.5.1-0/Dockerfile)
- `1.5.0-5` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.5.0-5/Dockerfile)
- `1.4.6-0` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.4.6-0/Dockerfile)
- `1.4.5-3` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.4.5-3/Dockerfile)
- `1.4.4-4` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.4.4-4/Dockerfile)
- `1.4.3-0` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.4.3-0/Dockerfile)
- `1.4.2-0` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.4.2-0/Dockerfile)
- `1.4.1-2` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.4.1-2/Dockerfile)
- `1.4.0-6` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.4.0-6/Dockerfile)
- `1.3.8-4` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.3.8-4/Dockerfile)
- `1.3.6` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.3.6/Dockerfile)
- `1.3.5` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.3.5/Dockerfile)
- `1.3.3` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.3.3/Dockerfile)
- `1.3.2-2` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.3.2-2/Dockerfile)
- `1.2.3-1` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.2.3-1/Dockerfile)
- `1.2.1` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.2.1/Dockerfile)
- `1.2.0-rc2-1` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.2.0-rc2-1/Dockerfile)
- `1.1.2-1` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.1.2-1/Dockerfile)
- `1.1.1-2` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.1.1-2/Dockerfile)
- `1.0.3-1` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/1.0.3-1/Dockerfile)
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
- TRAEFIK_HTTP_COMPRESSION="true"                       # Enable http compression
- TRAEFIK_HTTPS_ENABLE="false"							# "true" enables https and http endpoints. "Only" enables https endpoints and redirect http to https.
- TRAEFIK_HTTPS_PORT=8443								# https port > 1024 due to run as non privileged user
- TRAEFIK_HTTPS_MIN_TLS="VersionTLS12"					# Minimal allowed tls version to accept connections from
- TRAEFIK_HTTPS_COMPRESSION="true"                      # Enable https compression
- TRAEFIK_ADMIN_ENABLE="false"                          # "true" enables api, rest, ping and webui
- TRAEFIK_ADMIN_PORT=8000								# admin port > 1024 due to run as non privileged user
- TRAEFIK_ADMIN_SSL=false								# "true" enables https on api, rest, ping and webui using  `TRAEFIK_SSL_CRT` certificate
- TRAEFIK_ADMIN_STATISTICS=10                           # Enable more detailed statistics
- TRAEFIK_ADMIN_BASIC_AUTH_USERS=""                     # To enable basic auth on api, rest, ping and webui
- TRAEFIK_ADMIN_DIGEST_AUTH_USERS=""                    # To enable digest auth on api, rest, ping and webui
- TRAEFIK_CONSTRAINTS=""                                # Traefik constraint param. EG: \\"tag==api\\"
- TRAEFIK_LOG_LEVEL="INFO"								# Log level
- TRAEFIK_DEBUG="false"									# Enable/disable debug mode
- TRAEFIK_INSECURE_SKIP="false"							# Enable/disable InsecureSkipVerify parameter
- TRAEFIK_LOG_FILE="/opt/traefik/log/traefik.log"}		# Log file. Redirected to docker stdout.
- TRAEFIK_ACCESS_FILE="/opt/traefik/log/access.log"}	# Access file. Redirected to docker stdout.
- TRAEFIK_SSL_PATH="/opt/traefik/certs"					# Path to search .key and .crt files
- TRAEFIK_SSL_KEY=<DEMO KEY>                            # ssl key 
- TRAEFIK_SSL_KEY_FILE=${TRAEFIK_SSL_PATH}"/"${SERVICE_NAME}".key" # Default key file.
- TRAEFIK_SSL_CRT=<DEMO CRT>                            # ssl cert 
- TRAEFIK_SSL_CRT_FILE=${TRAEFIK_SSL_PATH}"/"${SERVICE_NAME}".crt"} # Default crt file.
- TRAEFIK_ACME_ENABLE="false"							# Enable/disable traefik ACME feature. [acme](http://v1-5.archive.docs.traefik.io/configuration/acme/)
- TRAEFIK_ACME_CHALLENGE=""                             # Set http | dns to activate traefik acme challenge mode. 
- TRAEFIK_ACME_CHALLENGE_HTTP_ENTRYPOINT="http"         # Set traefik acme http challenge entrypoint. [acme http challenge](http://v1-5.archive.docs.traefik.io/configuration/acme/#acmehttpchallenge)
- TRAEFIK_ACME_CHALLENGE_DNS_PROVIDER=""                # Set traefik acme dns challenge provider. You need to manually add configuration env variables accordingly the dns provider you use. [acme dns provider](http://v1-5.archive.docs.traefik.io/configuration/acme/#provider)
- TRAEFIK_ACME_CHALLENGE_DNS_DELAY=""                # Set traefik acme dns challenge delayBeforeCheck. [acme dns challenge](http://v1-5.archive.docs.traefik.io/configuration/acme/#acmednschallenge)
- TRAEFIK_ACME_EMAIL="test@traefik.io"					# Default email
- TRAEFIK_ACME_ONHOSTRULE="true"						# ACME OnHostRule parameter
- TRAEFIK_ACME_CASERVER="https://acme-v01.api.letsencrypt.org/directory"						# ACME caServer parameter
- TRAEFIK_FILE_ENABLE="false"							# Enable/disable file backend
- TRAEFIK_FILE_NAME="${SERVICE_HOME}/etc/rules.toml"    # File name for file backend
- TRAEFIK_K8S_ENABLE="false"							# Enable/disable traefik K8S integration
- TRAEFIK_RANCHER_ENABLE="false"						# Enable/disable traefik RANCHER integration
- TRAEFIK_RANCHER_REFRESH=15                            # Rancher poll refresh seconds
- TRAEFIK_RANCHER_MODE="api"                            # Rancher integration mode. api | metadata
- TRAEFIK_RANCHER_DOMAIN="rancher.internal"				# Rancher domain
- TRAEFIK_RANCHER_EXPOSED="false"						# Rancher ExposedByDefault
- TRAEFIK_RANCHER_HEALTHCHECK="false"					# Rancher EnableServiceHealthFilter
- TRAEFIK_RANCHER_INTERVALPOLL="false"      # Rancher enable/disable intervalpoll
- TRAEFIK_RANCHER_PREFIX="/2016-07-29"      # Rancher metadata prefix
- TRAEFIK_USAGE_ENABLE="false"              # Enable/disable send Traefik [anonymous usage collection](https://docs.traefik.io/basics/#collected-data) 
- TRAEFIK_METRICS_ENABLE="false"            # Enable/disable traefik [metrics](https://docs.traefik.io/configuration/metrics/)  
- TRAEFIK_METRICS_EXPORTER=""               # Metrics exporter prometheus | datadog | statsd | influxdb 
- TRAEFIK_METRICS_PUSH="10"                 # Metrics exporter push interval (s). datadog | statsd | influxdb
- TRAEFIK_METRICS_ADDRESS=""                # Metrics exporter address. datadog | statsd | influxdb 
- TRAEFIK_METRICS_PROMETHEUS_BUCKETS="[0.1,0.3,1.2,5.0]"  # Metrics buckets for prometheus
- CATTLE_URL=""											# Rancher API url
- CATTLE_ACCESS_KEY=""									# Rancher access key
- CATTLE_SECRET_KEY=""									# Rancher secret key

### Custom Configuration

Traefik is installed under /opt/traefik and make use of /opt/traefik/etc/traefik.toml and /opt/traefik/etc/rules.toml.

You can edit or overwrite this files in order to customize your own configuration or certificates.

You could also include FROM rawmind/alpine-traefik at the top of your Dockerfile, and add your custom config.

### SSL Configuration

Added SSL configuration. Set TRAEFIK_HTTPS_ENABLE="< true || only >" to enable it.

SSL certificates are located by default in /opt/traefik/certs. You need to provide .key AND .crt files to that directory, in order traefik gets automatically configured with ssl.

If you put more that one key/crt files in the certs directory, traefik gets sni enabled and configured. You also could map you cert storage volume to traefik and mount it in $TRAEFIK_SSL_PATH value.

You could also include FROM rawmind/alpine-traefik at the top of your Dockerfile, and add your custom ssl files.

If you need to let legacy tls versions connect to traefik then setting `TRAEFIK_HTTPS_MIN_TLS` will set `minVersion` on the https Entrypoint. See the traefik documentation for allowed values. Default is `VersionTLS12`.

### Letsencrypt Configuration

If you enable SSL configuration, you could enable traefik letsencrypt support as well (ACME). To do it, set TRAEFIK_ACME_ENABLE="true".


### Rancher

If you are running it in rancher, you could use in 2 ways:

- Traefik built rancher integration. Add env TRAEFIK_RANCHER_ENABLE=true
- You could run [rancher-traefik][rancher-traefik] as a sidekick to get dynamic configuration.


## Example

See [rancher-example][rancher-example], that run a traefik lb in all infrastructure servers and publish ${TRAEFIK_HTTP_PORT}, ${TRAEFIK_HTTPS_PORT} and ${TRAEFIK_ADMIN_PORT} throught them.


## TODO

Add sni automation to the traefik.

[alpine-monit]: https://github.com/rawmind0/alpine-monit/
[traefik]: https://github.com/containous/traefik
[rancher-traefik]: https://hub.docker.com/r/rawmind/rancher-traefik/
[rancher-example]: https://github.com/rawmind0/alpine-traefik/tree/master/rancher
