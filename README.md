# tor-privoxy-polipo

The smallest (**16 MB**) docker image with Tor, Privoxy and Polipo on Alpine Linux.

```
docker run -d -p 8118:8118 -p 9050:9050 -p 8123:8123 simonpure/tor-privoxy-polipo
curl --proxy localhost:8118 https://www.google.com
```

## Thanks

Based on https://github.com/rdsubhas/docker-tor-privoxy-alpine

## Known Issues

* When running in interactive mode, pressing Ctrl+C doesn't cleanly exit. For now, run it in detached mode (`-d`). Calling `docker stop` cleanly exits though.
* We're using `testing` versions of tor and runit in Alpine. Got to keep an eye on future builds, until those packages reach `main` in Alpine.

## Other interesting projects

* [s6 supervision suite](http://skarnet.org/software/s6/index.html), similar to runit and daemontools
* [s6-overlay](https://github.com/just-containers/s6-overlay), base container with s6 and alpine
* [docker-slim](https://github.com/cloudimmunity/docker-slim), a tool to automatically analyze and trim existing fat containers
