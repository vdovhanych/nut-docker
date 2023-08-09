FROM alpine:3.18

ARG BUILD_DATE

LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.license=GPL-2.0 \
    org.label-schema.name=nut-server \
    org.label-schema.vcs-url=https://github.com/vdovhanycch/nut-docker

ARG NUT_VERSION=2.8.0-r4
ENV API_USER=upsmon \
    API_PASSWORD=secret \
    NAME=ups \
    DRIVER=usbhid-ups \
    PORT=auto \
    DESCRIPTION=UPS \
    SERIAL= \
    VENDORID= \
    SDORDER= \
    SERVER=master \
    POLLINTERVAL=1\
    MAXRETRY=3 \
    GROUP=nut \
    USER=nut

RUN apk add --update nut=$NUT_VERSION \
      libcrypto1.1 libssl1.1 libusb musl net-snmp-libs

HEALTHCHECK CMD upsc ups@localhost:3493 2>&1|grep -q stale && exit 1 || true

EXPOSE 3493
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT /usr/local/bin/entrypoint.sh
