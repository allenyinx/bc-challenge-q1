#!/bin/bash

# Only initialize if not already configured
# Seems the genesis.json is required to be present in the config directory
if [ ! -f "/root/.chain-maind/config/genesis.json" ]; then
  echo "Initializing new node..."

  chain-maind init my-node --chain-id my-test-chain

  # Create validator key
  echo -e "testpassword\ntestpassword" | chain-maind keys add validator --keyring-backend test

  # Add genesis account
  chain-maind add-genesis-account validator 1000000000000basecro --keyring-backend test

  echo -e "testpassword" | chain-maind gentx validator 900000000000basecro \
    --chain-id my-test-chain \
    --keyring-backend test

  chain-maind collect-gentxs

  sed -i 's/minimum-gas-prices = ""/minimum-gas-prices = "0.1basecro"/' /root/.chain-maind/config/app.toml
fi

# Start node.
# PS. i don't know exactly why the minimum-gas-prices is set here, but it is necessary for the node to start
chain-maind start \
  --rpc.laddr=tcp://0.0.0.0:26657 \
  --api.address=tcp://0.0.0.0:1317 \
  --minimum-gas-prices=0.1basecro