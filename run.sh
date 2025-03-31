#!/bin/bash

##############################################################################################
# Filename   : build.sh                                                                       #
# Author     : Allen Yin                                                                      #
# Created    : 2025-Mar                                                                       #
# Purpose    : launch the crypto node                                                         #
# Reference  : https://docs.cronos-pos.org/cronos-pos-integration/node-and-rpc-setup-notes    #
##############################################################################################

# receive the input argument as the version
version=$1
if [ -z "$version" ]; then
  version="1.6"
fi

# Run with mounted storage
docker run -d \
  -p 26657:26657 \
  -p 1317:1317 \
  -v ./chain-data:/root/.chain-maind \
  crypto-validator:$version