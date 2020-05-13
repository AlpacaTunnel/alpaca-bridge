#!/bin/bash

set -e

download()
{
    url=$1
    dir=$2

    rm -f /tmp/code.zip
    rm -rf /tmp/code

    curl -L $url -o /tmp/code.zip
    unzip /tmp/code.zip -d /tmp/code/
    mv /tmp/code/* $dir
}


mkdir -p /usr/local/etc/alpaca-tunnel.d/

download https://github.com/17mon/china_ip_list/archive/master.zip /tmp/china_ip_list
mv /tmp/china_ip_list/china_ip_list.txt /usr/local/etc/alpaca-tunnel.d/china_ip_list.txt
rm -rf /tmp/china_ip_list

download https://github.com/felixonmars/dnsmasq-china-list/archive/master.zip /tmp/dnsmasq-china-list
mv /tmp/dnsmasq-china-list/*.conf /etc/dnsmasq.d/
rm -rf /tmp/dnsmasq-china-list/

download https://github.com/AlpacaTunnel/alpaca-py/archive/master.zip /usr/local/bin/alpaca-py
