FROM ubuntu:20.04

MAINTAINER alpaca.tunnel@gmail.com

ENV DEBIAN_FRONTEND noninteractive

COPY sources.list /etc/apt/sources.list

RUN apt-get update --fix-missing && \
    apt-get -y --fix-missing install \
    iproute2 iptables tcpdump iputils-ping dnsutils curl unzip vim \
    golang-go dnsmasq squid shadowsocks-libev && \
    apt-get clean

COPY download-code.sh /tmp/download-code.sh
RUN /tmp/download-code.sh

RUN cd /tmp/alpaca-go/ && go build && mv alpaca-go /usr/local/bin/ && rm -rf /tmp/*

COPY config.json /usr/local/etc/alpaca-tunnel.d/
COPY secrets.txt /usr/local/etc/alpaca-tunnel.d/

COPY dnsmasq.conf /etc/dnsmasq.conf
COPY squid.conf /etc/squid/squid.conf

COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
