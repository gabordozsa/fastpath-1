#! /bin/bash

set -eu

IP="$1"
NS="$2"
VETH0="veth2"
VETH1="veth3"

ip netns exec $NS ip link add $VETH0 type veth peer name $VETH1
ip netns exec $NS ip addr add $IP dev $VETH0
ip netns exec $NS ip link set dev $VETH0 up
ip netns exec $NS ip link set dev $VETH1 up
ip netns exec $NS ip link set dev $VETH0 arp off
ip netns exec $NS ethtool -K $VETH0 tx off rx off
# ip netns exec $NS ip route add ${PEER_IP%.*}.0/24 dev $VETH0