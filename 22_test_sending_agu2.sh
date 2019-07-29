#!/bin/sh

SET=$(seq 0 13)
for i in $SET
#반복문
do
#11번 라인 추가.
echo "Running loop seq "$i    IPV6
sed -i '$iatestrpcuser=1$i/' /root/setup_mn/./README.md
    # some instructions
done
