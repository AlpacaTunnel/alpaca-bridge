#!/bin/bash

set -e

[ -z $PASSWORD ] && echo "Use default password: mypassword" && PASSWORD=mypassword

echo "password is: $PASSWORD"

# mock google's 8.8.8.8
ip tuntap add dev tun8 mode tun
ip link set tun8 up
ip addr add 8.8.8.8/32 dev tun8

echo "nameserver 8.8.8.8" > /etc/resolv.conf

dnsmasq --conf-file=/etc/dnsmasq.conf

squid

ss-server -s 0.0.0.0 -p 1080 -m chacha20-ietf-poly1305 -d 8.8.8.8 -k $PASSWORD > /dev/null &

exec /usr/local/bin/alpaca-go
