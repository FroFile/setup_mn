#!/bin/bash

TMP_FOLDER=$(mktemp -d)
CONFIG_FILE='mastercorecoin.conf'
CONFIGFOLDER='/root/.mastercorecoincore'
COIN_DAEMON='mastercorecoind'
COIN_CLI='mastercorecoin-cli'
COIN_PATH='/usr/bin/'
#COIN_TGZ='https://cdmcoin.org/condominium_ubuntu.zip'
#COIN_ZIP=$(echo $COIN_TGZ | awk -F'/' '{print $NF}')
COIN_NAME='mastercorecoin'
#COIN_EXPLORER='http://chain.cdmcoin.org'
COIN_PORT=29871
RPC_PORT=29872
SET_NUM=15

BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'

#전달값 확인.
IPV4=$1
IPV6=$2

function check_system_ipv4() {
    echo -e "* Checking system for compatibilities"
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}$0 must be run as root.${NC}"
   exit 1
fi

if [[ -r /etc/os-release ]]; then
    . /etc/os-release
	echo -e "Verision ${VERSION_ID}"
	if [[ "${VERSION_ID}" != "16.04" ]] ; then
		echo -e "This script only supports Ubuntu 16.04 LTS, exiting."
		exit 1
	fi
else
    echo -e "This script only supports Ubuntu 16.04 LTS, exiting."
    exit 1
fi

NODEIP=$(curl -s4 icanhazip.com)
#IPv6는 read로 전달하도록 해야할듯.

if [[ $NODEIP != $IPV4 ]]; then
   echo -e "${RED} IPv4 and IPv6 must match. You check IPc4.${NC}"
   exit 1
fi

echo -e "${RED}*** Checking system and IPv4 *** "
}

echo -e "${RED}==========================================================================${NC}"
echo -e "${RED}==========================================================================${NC}"


SET=$(seq 0 $SET_NUM)
for i in $SET
do
echo "Running loop seq "$i
    # some instructions
done


function add_ipv6() {

#ipv6가 추가되어있냐?
if [[ $NODEIP != $IPV4 ]]; then
 echo -e "${RED} IPv4 and IPv6 must match. You check IPc4.${NC}"
 exit 1
fi

iface ens3 inet6 static
13:address 2001:19f0:7002:137::1
14:netmask 64
15:up /sbin/ip -6 addr add dev ens3 2001:19f0:7002:137::2
16:up /sbin/ip -6 addr add dev ens3 2001:19f0:7002:137::3
17:up /sbin/ip -6 addr add dev ens3 2001:19f0:7002:137::4
18:up /sbin/ip -6 addr add dev ens3 2001:19f0:7002:137::5


#11번 라인 삭제
  sed -i '11d' /etc/network/interfaces
  
for ((AN1=0; AN1<=; n2++))
#11번 라인 추가.
  sed -i '11aiface ens3 inet6 static'
#12번 라인 추가
  
}

echo -e "${RED}==========================================================================${NC}"
echo -e "${RED}==========================================================================${NC}"

#read -p "IPv6?" NODEIPv6
#echo -e "${NODEIPv6}1"  
#sed -i '3atestrpcuser=1/' /root/setup_mn/./README.md
#sed -i "3a${NODEIPv6}1=1/" /root/setup_mn/./README.md

$COIN_PATH$COIN_CLI stop
sleep 2

$COIN_PATH$COIN_DAEMON -daemon
sleep 10

GENKEY=$( $COIN_PATH$COIN_CLI masternode genkey)
echo -e "123456789"
echo -e "${GENKEY}"

GENKEY=$( $COIN_PATH$COIN_CLI masternode genkey)
echo -e "223456789"
echo -e "${GENKEY}"


function edit_macc_add_IPv6() {
  $COIN_PATH$COIN_CLI stop
  sleep 2
  
  cat << EOF >> $CONFIGFOLDER/$CONFIG_FILE
 
EOF

  sleep 2
  $COIN_PATH$COIN_DAEMON -daemon
  sleep 2
  echo -e "${RED}addnode work is done${NC}"

  $COIN_PATH$COIN_CLI getinfo
}

check_system_ipv4
#edit_macc_add_IPv6
