#!/bin/bash

cd ~/scripts/

Moisture=$(jq -r '.Moisture' ~/scripts/flora.json)
echo "Bodenfeuchtigkeit: $Moisture"

if [ $Moisture -gt 0 ] && [ $Moisture -lt 20 ]
then

echo "Pumpe an"
tplink-smarthome-api setPowerState 192.168.1.181 true
echo "pumping ;-) ..."
sleep 3
echo "Pumpe aus"
tplink-smarthome-api setPowerState 192.168.1.181 false

fi

echo "Strom aus (Fallback)"
tplink-smarthome-api setPowerState 192.168.1.181 false

echo "Status Benny:"

./../miflora/flora.py poll C4:7C:8D:6A:4F:79
