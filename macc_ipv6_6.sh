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

NODEIP=$(curl -s4 icanhazip.com)
#IPv6는 read로 전달하도록 해야할듯.

BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'

echo -e "${RED}================================================================================================================================${NC}"
echo -e "${RED}================================================================================================================================${NC}"

read -p "IPv6?" NODEIPv6

echo "$NODEIP`s IPv6 is $NODEIPv6"  

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

#edit_macc_add_IPv6

echo -e "${RED} ${NODEIP} {NC}"
