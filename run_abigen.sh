#!/bin/bash

read -p 'Input solidity json filename in your hardhat/data/abi folder (e.g.: Greeter): ' FILENAME

docker run -v $(pwd)/hardhat:/sources -v $(pwd)/backend:/targets ethereum/client-go:alltools-stable abigen \
  --abi=sources/data/abi/$FILENAME.json \
  --type $FILENAME \
  --pkg contracts \
  --out=targets/contracts/$FILENAME.go
