#set -x
COMMAND="diff $@"
alias pf='printf'
find . -type f -name '*.nix' -exec bash -c "printf '%s\n\n' '>>>>> {} <<<<<'  ;  ${COMMAND} /etc/nixos/{} {}  ;  printf '\n%s\n\n' '-----------------'" \;
