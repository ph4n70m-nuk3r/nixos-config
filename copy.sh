#!/usr/bin/env bash
set -e -u -o pipefail
find /etc/nixos  -type f  -exec  cp -t ./  {} +
