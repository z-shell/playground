#!/usr/bin/env zsh

command curl "https://sh.rustup.rs" -sSf | sh -s -- -y || true

if [[ -f "${HOME}/.cargo/env" ]]; then
  print "source ${HOME}/.cargo/env" >>"${HOME}"/.zshenv
  source "${HOME}/.cargo/env"

  sudo apt update
  sudo DEBIAN_FRONTEND=noninteractive apt install --yes tlp lscolors fd-find fzf
  cargo install lsd
fi
