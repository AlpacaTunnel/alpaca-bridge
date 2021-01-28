# alpaca-container

Shadowsocks/Squid via alpaca-tunnel.

## Usage

There 2 files need to change:

- `config.json`: configuration of alpaca-tunnel.
- `secrets.txt`: alpaca-tunnel peers and PSKs.

You can edit these 2 files, and build into the Docker image, or you can mount them from Docker host.

The `PASSWORD` here is shadowsocks password, and the default encryption method is `aes-256-cfb`. Edit `entrypoint.sh` if you need another method.

```sh
$ docker build . -t ss-via-alp-1.1
$ docker run --privileged -d -p 8964:1080 -e PASSWORD=anotherpass --name ss-8964-via-alp-1.1 ss-via-alp-1.1
```

Or mount the configurations:

```sh
docker run --privileged -d -p 8964:1080 -e PASSWORD=anotherpass --name ss-8964-via-alp-1.1 \
    -v path/to/config.json:/usr/local/etc/alpaca-tunnel.d/config.json \
    -v path/to/secrets.txt:/usr/local/etc/alpaca-tunnel.d/secrets.txt ss-via-alp-1.1
```
