#!/bin/bash

##############################################################################################
# Filename   : sync.sh                                                                       #
# Author     : Allen Yin                                                                      #
# Created    : 2025-Mar                                                                       #
# Purpose    : a sample to sync the mounted volume with S3                                    #
# Reference  : https://docs.cronos-pos.org/cronos-pos-integration/node-and-rpc-setup-notes    #
##############################################################################################

# check if aws cli is installed
if ! command -v aws &> /dev/null
then
    echo "aws cli could not be found on the host!"
    exit
fi

# check if the chain-data directory exists
if [ ! -d "./chain-data" ]
then
    echo "chain-data directory could not be found on the host!"
    exit
fi

aws s3 sync ./chain-data s3://my-bucket/backups --region us-east-1