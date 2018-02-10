#!/bin/bash

#########################
#      VARIAVEIS        #
#########################
WIFI=wlp1s0
ETHERNET=enp2s0

#########################
# LIMPA TODAS AS REGRAS #
#########################

# IPv4
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

# IPv6
ip6tables -F
ip6tables -X
ip6tables -F -t mangle
ip6tables -X -t mangle

#######################
# MODULOS DO FIREWALL #
#######################
#modprobe iptable_nat		# Tabela nat
#modprobe ip_conntrack_ftp	# 
#modprobe ip_nat_ftp		# 
#modprobe ipt_LOG			# Habilitar LOG
modprobe ipt_REJECT			# Habilita REJECT
#modprobe ipt_MASQUERADE	# Habilitar MASQUERADE
#modprobe ipt_multiport		# Habilitar multiport

############################
# ESTABELECER NOVAS REGRAS #
############################

# Politica geral
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP
ip6tables -P INPUT DROP
ip6tables -P OUTPUT ACCEPT
ip6tables -P FORWARD DROP

# PING
# Negar qualquer tipo de ping:
#iptables -A INPUT -i $ETHERNET -p icmp --icmp-type 0 -j DROP
#iptables -A FORWARD -i $ETHERNET -p  icmp --icmp-type 0 -j DROP
#iptables -A INPUT -i $ETHERNET -p icmp --icmp-type 8 -j DROP
#iptables -A FORWARD -i $ETHERNET -p  icmp --icmp-type 8 -j DROP
#iptables -A INPUT -i $WIFI -p icmp --icmp-type 0 -j DROP
#iptables -A FORWARD -i $WIFI -p  icmp --icmp-type 0 -j DROP
#iptables -A INPUT -i $WIFI -p icmp --icmp-type 8 -j DROP
#iptables -A FORWARD -i $WIFI -p  icmp --icmp-type 8 -j DROP

# SSH
# Negar qualquer conexão por SSH
iptables -A INPUT -p tcp --dport 22 -j DROP
iptables -A INPUT -p udp --dport 22 -j DROP
ip6tables -A INPUT -p tcp --dport 22 -j DROP
ip6tables -A INPUT -p udp --dport 22 -j DROP

# tor
# Permitir conexão tor
iptables -A INPUT -i $WIFI -p tcp --dport 51413 -j ACCEPT

# HTTP
# Permitir conexão com internet
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
ip6tables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -m state --state INVALID -j DROP
ip6tables -A INPUT -m state --state INVALID -j DROP

# INTERNET
# Ports padrão
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 80 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 443 -j ACCEPT

# LOOP
# Manter o system funcionando devidamente
iptables -A INPUT -i lo -j ACCEPT
