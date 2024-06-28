#!/bin/bash

#Assicurati di avere i pacchetti necessari installati, come bridge-utils per brctl e dnsmasq per il server DHCP
#Puoi installarli usando il seguente comando:
#sudo apt-get install bridge-utils dnsmasq

# Assicurati di essere root
if [[ $EUID -ne 0 ]]; then
    echo "Questo script deve essere eseguito come root"
    exit 1
fi

# Parametri
BRIDGE_NAME=${1:-br0}
TAP_NAME=${2:-tap0}
BRIDGE_IP=${3:-192.0.3.1/24}
DHCP_RANGE_START=${4:-192.0.3.2}
DHCP_RANGE_END=${5:-192.0.3.254}
ROUTE_NETWORK=${6:-192.0.2.0/24}
ROUTE_GATEWAY=${7:-192.0.3.76}

# Creazione del bridge
brctl addbr $BRIDGE_NAME

# Creazione del dispositivo tap e assegnazione all'utente corrente
tunctl -t $TAP_NAME -u `whoami`

# Aggiunta del dispositivo tap al bridge
brctl addif $BRIDGE_NAME $TAP_NAME

# Attivazione delle interfacce tap e bridge
ifconfig $TAP_NAME up
ifconfig $BRIDGE_NAME up

# Visualizzazione della configurazione del bridge
brctl show

# Configurazione dell'indirizzo IP sul bridge
ip addr add $BRIDGE_IP dev $BRIDGE_NAME

# Assicurarsi che il bridge sia attivo
ip link set $BRIDGE_NAME up

# Configurazione di dnsmasq per fornire DHCP sul bridge
dnsmasq --interface=$BRIDGE_NAME --bind-interfaces --dhcp-range=$DHCP_RANGE_START,$DHCP_RANGE_END

# Aggiunta di una rotta per la rete specificata
ip route add $ROUTE_NETWORK via $ROUTE_GATEWAY

