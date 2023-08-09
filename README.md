# NUT (Network UPS Tools) but in docker

I wanted to have a simple way to monitor my UPS (APC Back-UPS ES 700G) and shutdown my server when the battery is low. I found [NUT](http://networkupstools.org/) and it works great. I just needed to install it on my server and configure it to monitor my UPS. I also wanted to have easy configuration and updates, so I decided to put it in a docker container.

## Usage (docker-compose)


```yaml
version: "3.8"

services:
  nut_server:
    image: ghcr.io/vdovhanych/nut-docker:latest
    restart: always
    network_mode: host
    devices:
      - /dev/bus/usb/001/003 # change to your device by running `lsusb` and finding your UPS
    environment:
      - API_USER=upsmon
      - API_PASSWORD=secret
      - NAME=ups
      - DRIVER=usbhid-ups
      - PORT=auto
      - DESCRIPTION=UPS
      - SERIAL=
      - VENDORID=
      - SDORDER=
      - SERVER=master
      - POLLINTERVAL=1
      - MAXRETRY=3
      - GROUP=nut
      - USER=nut
    container_name: nut-server
    hostname: nut-server
```

