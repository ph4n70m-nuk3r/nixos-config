find . -type f -name '*.nix' -exec bash -c "diff '/etc/nixos/{}' '{}'" \;
