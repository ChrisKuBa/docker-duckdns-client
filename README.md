# duckdns-client

Field of use: IPV6 only address (with/out a public IPV4 address) with [duckdns](https://duckdns.org/).

This simple alpine docker container updates the ipv6 address of a duckdns zone/domain.

It is recommended using a static Interface-ID (EUI-64-Identifier) if address is used for services and one or many ports must be forward through a firewall or router (see /etc/dhcpcd.conf slaac hwaddr).

The architectures supported by this image are:

| Architecture | Tag | 
| ------ | ------ |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v7-latest |

## Usage

docker image: https://hub.docker.com/r/chriskuba/duckdns-client

### docker-compose
```
---
version: "0.0.1"
service:
  duckdns-client:
    image: chriskuba/duckdns-client
    container-name: duckdns-client
    environment:
      - ZONE=myzone.duckdns.org
      - TOKEN=mysecuretoken
      - SLEEP=500 #optional
      - INTERFACE=eth0 #optional
      - GREP="scope global dynamic" #optional
    restart: always
    network_mode: host
```

### docker-cli
```
docker run -d \
  --name=duckdns-client \
  -e ZONE=myzone.duckdns.org \
  -e TOKEN=mysecuretoken \
  -e SLEEP=500 `#optional` \
  -e INTERFACE=eth0 `#optional` \
  -e GREP="scope global dynamic" `#optional` \
  --restart always
  --network host
  chriskuba/duckdns-client
```

### Parameters
| Parameter | Function |
| ------ | ------ |
| -e ZONE | zone/domain of dynvpn to update - eg. myzone.duckdns.org |
| -e TOKEN | secure token of your duckdns account |
| -e SLEEP=500 | seconds between to updates |
| -e INTERFACE=eth0 | interface to read ip from |
| -e GREP="scope global dynamic" | unique string to identify the correct ipv6 (if multiple exists) |

## Known Issues
The alpine docker image is fix to the last 1.12 version because of a dns resolving bug in newer version.
https://github.com/alpinelinux/docker-alpine/issues/155
https://github.com/nginxinc/docker-nginx/issues/508