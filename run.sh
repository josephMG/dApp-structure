#!/bin/bash

parallel -j3 --lb 'cd ${PWD}/{} ; pwd ; docker-compose up' ::: hardhat backend frontend
