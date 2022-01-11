#!/bin/bash

#show processes from top command only to root user

WHOAMI=$(whoami)

if [ "$WHOAMI" != "root" ]; then
  echo "You are not root, exiting"
  exit 1
fi

top
