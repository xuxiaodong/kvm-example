#!/bin/sh -eux

for x in `seq 0 2` ; do
  nix-env --delete-generations old
  nix-collect-garbage -d
done
