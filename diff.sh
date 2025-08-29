#!/usr/bin/env bash
set -e -u -o pipefail
COMMAND="diff $@"
find . -type f -name '*.nix' -exec bash -c "printf '%s\n\n' '>>>>> {} <<<<<'  ;  ${COMMAND} /etc/nixos/{} {}  ;  printf '\n%s\n\n' '-----------------'" \;
