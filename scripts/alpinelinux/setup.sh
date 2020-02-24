#!/bin/sh -eux

printf "vagrant\nvagrant\n" | adduser vagrant
addgroup vagrant wheel
