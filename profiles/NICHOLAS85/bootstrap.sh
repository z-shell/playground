#!/usr/bin/env zsh
# shellcheck disable=SC2250,2312,1091
curl "https://sh.rustup.rs" -sSf | sh -s -- -y
echo "source ${HOME}/.cargo/env" >>"${HOME}"/.zshenv

source "$HOME/.cargo/env"

sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install --yes tlp lscolors fd-find fzf
cargo install lsd
