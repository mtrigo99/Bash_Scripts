#!/bin/bash

for ip in $(seq 1 254); do
  ping -c 1 -W 1 10.100.34.$ip | grep "64 bytes" &
done