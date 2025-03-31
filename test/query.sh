#!/bin/bash

##############################################################################################
# Filename   : query.sh                                                                       #
# Author     : Allen Yin                                                                      #
# Created    : 2025-Mar                                                                       #
# Purpose    : test the crypto node response                                                  #
# Reference  : https://docs.cronos-pos.org/cronos-pos-integration/node-and-rpc-setup-notes    #
##############################################################################################

# check the cli is installed
if ! command -v chain-maind &> /dev/null
then
    echo "chain-maind could not be found on the host!"
    exit
fi

# define the target node address
bcNode="localhost:26657"

# balance query
chain-maind query bank balances cro1hsr226lr7k2szjktzjst46rr9cfavprqas20gc --node tcp://$bcNode

# block hash query
curl http://$bcNode/block?height=13947398