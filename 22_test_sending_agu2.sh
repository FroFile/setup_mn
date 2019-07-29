#!/bin/sh

SET=$(seq 0 13)
for TG in $SET
#반복문
do
#11번 라인 추가.
echo "Running loop seq "$TG    IPV6
sed -i '$TGatestrpcuser=1$TG/' /root/setup_mn/./README.md
    # some instructions
done
