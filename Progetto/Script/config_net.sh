#!/bin/bash


# Parametri
INTERFACE=${1:-eth1}
IP_ADDRESS=${2:-192.0.2.1/24}
DHCP_CONF=${3:-/etc/dhcp/dhcpd.conf}
DHCP_LEASES=${4:-/var/lib/dhcp/dhcpd.leases}

# Portare giù l'interfaccia
echo "Bringing down interface $INTERFACE..."
ip link set dev $INTERFACE down

# Configurazione dell'indirizzo IP sull'interfaccia
echo "Configuring IP address $IP_ADDRESS on $INTERFACE..."
ip addr add $IP_ADDRESS dev $INTERFACE

# Portare su l'interfaccia
echo "Bringing up interface $INTERFACE..."
ip link set dev $INTERFACE up

# Avviare il server DHCP
echo "Starting DHCP server on $INTERFACE..."
dhcpd -d -4 -cf $DHCP_CONF -lf $DHCP_LEASES $INTERFACE &

# Configurazione delle regole di NAT con iptables
echo "Adding iptables DNAT rules..."
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT



