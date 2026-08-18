#! /bin/bash

set -eu

IP="$1"

ip link add veth0 type veth peer name veth1
ip addr add $IP dev veth0
ip link set dev veth0 up
ip link set dev veth1 up
ip link set dev veth0 arp off
ethtool -K veth0 tx off rx off