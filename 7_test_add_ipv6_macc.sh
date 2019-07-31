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
SET_NUM=6

BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'

#전달값 확인.
IPV4V=$1
IPV6V=$2

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

#혹시 IPv4를 잘못붙여넣지 않았는지 확인.
if [[ $NODEIP != $IPV4V ]]; then
   echo -e "${RED} IPv4 and IPv6 must match. You check IPc4. ${IPV4V}${NC}"
   exit 1
fi

echo -e "${RED}*** Checking system and IPv4 OK *** "
}

echo -e "${RED}==========================================================================${NC}"
echo -e "${RED}==========================================================================${NC}"

function add_reboot_ipv6() {
#ipv6가 추가되어 있는지를 어떻게 알 수 있을까... 어떻게 추가할까...
#if [[ ~~~ != ~~~~ ]]; 

#11번 라인 삭제, Auto를 삭제함.
  sed -i '11d' /etc/network/interfaces
  
#IPv6 추가하기. 맨끝에 변하는 자리 하나는 빼놓고 넣어주기.
  cat << EOF >> $CONFIGFOLDER/$CONFIG_FILE
iface ens3 inet6 static
address ${IPV6V}1
netmask 64
up /sbin/ip -6 addr add dev ens3 ${IPV6V}2
up /sbin/ip -6 addr add dev ens3 ${IPV6V}3
up /sbin/ip -6 addr add dev ens3 ${IPV6V}4
up /sbin/ip -6 addr add dev ens3 ${IPV6V}5
up /sbin/ip -6 addr add dev ens3 ${IPV6V}6 
up /sbin/ip -6 addr add dev ens3 ${IPV6V}7
up /sbin/ip -6 addr add dev ens3 ${IPV6V}8
up /sbin/ip -6 addr add dev ens3 ${IPV6V}9 
up /sbin/ip -6 addr add dev ens3 ${IPV6V}a
up /sbin/ip -6 addr add dev ens3 ${IPV6V}b
up /sbin/ip -6 addr add dev ens3 ${IPV6V}c 
up /sbin/ip -6 addr add dev ens3 ${IPV6V}d
up /sbin/ip -6 addr add dev ens3 ${IPV6V}e
up /sbin/ip -6 addr add dev ens3 ${IPV6V}f 
EOF #파일끝 

#일단은 네트워크는 추가해놓는게 좋을듯해서 추가함.

#네트워크 재부팅
systemctl restart networking.service
sleep 3

#추가했던 네트워크들이 확인되는지 체크하기
ip addr show ens3
sleep 3
} 

echo -e "${RED}==========================================================================${NC}"
echo -e "${RED}==========================================================================${NC}"

function edit_macc_addnode() {
#복사전... 이 부분 POPC는 달라져야 함...################
sed -i '3d' $CONFIGFOLDER/$CONFIG_FILE

##고정값 추가 및 addnode 
##아직 정지안했음.
  cat << EOF >> $CONFIGFOLDER/$CONFIG_FILE
 maxconnections=256
 logtimestamps=1
 port=29871
 
addnode=45.32.36.18
addnode=202.182.101.162
addnode=149.28.31.156
addnode=45.63.121.56
addnode=149.28.19.210
addnode=107.191.53.220
addnode=45.77.183.241
addnode=45.76.52.233
addnode=198.13.37.49
addnode=45.77.29.239
addnode=128.199.171.192
addnode=45.77.21.70
addnode=198.13.38.119
addnode=45.32.39.247
addnode=95.179.154.9
addnode=157.230.123.11
addnode=104.248.141.211
addnode=178.128.54.41
addnode=204.48.26.40
addnode=207.154.201.240
addnode=159.89.151.147
addnode=167.99.206.80
addnode=138.68.103.119
addnode=134.209.225.16
addnode=159.65.139.78
addnode=68.183.64.70
addnode=104.248.157.119:34652
addnode=104.248.39.113:29871
addnode=112.162.233.135:50514
addnode=113.10.36.11:60418
addnode=128.199.155.59:55256
addnode=128.199.167.13:29871
addnode=128.199.171.192:37988
addnode=128.199.175.9:42000
addnode=128.199.251.99:47266
addnode=134.209.108.46:60394
addnode=134.209.108.51:49510
addnode=134.209.225.16:58492
addnode=134.209.233.131:52286
addnode=134.209.240.245:51216
addnode=134.209.246.108:42116
EOF

  sleep 2
  echo -e "${RED}addnode work is done${NC}"

  sleep 2
  $COIN_PATH$COIN_CLI getinfo
}

echo -e "${RED}==========================================================================${NC}"
echo -e "${RED}==========================================================================${NC}"

function copy_dir_add_conf() {
#반복문으로 대체하자
cp -r -p $CONFIGFOLDER ${CONFIGFOLDER}1
cp -r -p $CONFIGFOLDER ${CONFIGFOLDER}2
cp -r -p $CONFIGFOLDER ${CONFIGFOLDER}3
cp -r -p $CONFIGFOLDER ${CONFIGFOLDER}4
cp -r -p $CONFIGFOLDER ${CONFIGFOLDER}5
cp -r -p $CONFIGFOLDER ${CONFIGFOLDER}6

sed -i '1s/rpcuser=/rpcuser=1/'  $CONFIGFOLDER/$CONFIG_FILE
sed -i '2s/rpcpassword=/rpcpassword=1/'  $CONFIGFOLDER/$CONFIG_FILE
sed -i '2arpcport=298721'  $CONFIGFOLDER/$CONFIG_FILE
sed -i '5s/listen=1/listen=0/'  $CONFIGFOLDER/$CONFIG_FILE
sed -i '8cbind=[2001:19f0:7002:137::1]'  $CONFIGFOLDER/$CONFIG_FILE
sed -i '9cexternalip=[2001:19f0:7002:137::1]:29871'  $CONFIGFOLDER/$CONFIG_FILE
#젠키 같다 붙이기.
sed -i '12cmasternodeprivkey=7UHamy5JQc7Zs2RaXPTLZTGju8RSD2tFZWxx9z3BW2yKvKqvY3J' /root/.mastercorecoincore1/mastercorecoin.conf

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


}




check_system_ipv4
add_reboot_ipv6
edit_macc_addnode
copy_dir_add_conf

