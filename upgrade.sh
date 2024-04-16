#!/usr/bin/env bash

cd /home/vikko/local_projects/nixos && nix flake update --commit-lock-file
nixos-rebuild switch
nvd diff `echo /nix/var/nix/profiles/system-*-link | rev | cut -d" " -f1-2 | rev`'
