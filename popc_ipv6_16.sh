#!/bin/bash

BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'


wget -qO- https://github.com/mastercorecoin/mastercorecoin/releases/download/1.0.0.0/macc_mn_installer.sh | bash

mastercorecoin-cli stop

echo -e "${GREEN}Searching and removing old $COIN_NAME files and configurations${NC}"

rm -rf /root/setup_mn
