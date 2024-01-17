#!/bin/bash

read -p "Introduce la IP de la TPV (No máster): " direcip

scp ficha.txt root@$direcip:/etc/udev/rules.d/
