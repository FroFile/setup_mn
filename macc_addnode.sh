#!/bin/bash

TMP_FOLDER=$(mktemp -d)
CONFIG_FILE='mastercorecoin.conf'
CONFIGFOLDER='/root/.mastercorecoincore'
COIN_DAEMON='mastercorecoind'
COIN_CLI='mastercorecoin-cli'
COIN_PATH='/usr/local/bin/'
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

echo -e "${BLUE}================================================================================================================================${NC}"
echo -e "${BLUE}================================================================================================================================${NC}"

function Macc_addnodes() {
  $COIN_PATH$COIN_CLI stop
  
  cat << EOF > $CONFIGFOLDER/$CONFIG_FILE
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
addnode=134.209.233.131:52286
addnode=134.209.240.245:51216
addnode=134.209.246.108:42116
EOF
  sleep 10
  $COIN_PATH$COIN_DAEMON -daemon
  sleep 10
 echo -e "${BLUE}addnode work is done${NC}"

  $COIN_PATH$COIN_CLI getinfo
}
