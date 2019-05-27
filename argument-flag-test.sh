#!/bin/bash

while getopts u:d:p:f: option
do
case "${option}"
in
u) USER=${OPTARG};;
d) DATE=${OPTARG};;
p) PRODUCT=${OPTARG};;
f) FORMAT=$OPTARG;;
esac
done

echo "Flagged Parameters"
echo 'u) USER= ' $USER
echo 'd) DATE= ' $DATE
echo 'p) PRODUCT= ' $PRODUCT
echo 'f) FORMAT= ' $FORMAT