#!/bin/bash

echo "#######################################################"
echo "Welcome $USER on $HOSTNAME."

FREERAM=$(free -m | grep Mem | awk '{print $4}')
LOAD=$(uptime | awk '{print $8,$9,$10,$11,$12}')
ROOTFREE=$(df -h | grep '/dev/sda1' | awk '{print $4}')

echo "#######################################################"
echo "Available free RAM is $FREERAM MB"
echo "#######################################################"
echo "Current Load Average $LOAD"
echo "#######################################################"
echo "Free ROOT partiotion size is $ROOTFREE"
echo "#######################################################"
