alpine-traefik
==============

This image is the traefik base. It comes from rawmind/alpine-monit.

## Build

```
docker build -t rawmind/alpine-traefik:<version> .
```

## Versions

- `1.0.0-beta` [(Dockerfile)](https://github.com/rawmind0/alpine-traefik/blob/master/Dockerfile)


## Usage

To use this image include `FROM rawmind/alpine-traefik` at the top of your `Dockerfile`. Starting from `rawmind/alpine-monit` provides you with the ability to easily start any service using monit. monit will also keep it running for you, restarting it when it crashes.

To start your service using monit:

- create a monit conf file in `/opt/monit/etc/conf.d`
- create a service script that allow start, stop and restart function
