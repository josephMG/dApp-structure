#!/bin/bash

docker run -v $(pwd)/hardhat:/sources -v $(pwd)/backend:/targets ethereum/client-go:alltools-stable abigen \
  --abi=sources/data/abi/Greeter.json \
  --type Greeter \
  --pkg contracts \
  --out=targets/contracts/Greeter.go
