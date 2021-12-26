#!/usr/bin/env zsh

curl 'https://sh.rustup.rs' -sSf | sh -s -- -y
echo 'source ${HOME}/.cargo/env' >> ${HOME}/.zshenv
source $HOME/.cargo/env

sudo apt install --yes tlp lscolors fd-find fzf
cargo install lsd
