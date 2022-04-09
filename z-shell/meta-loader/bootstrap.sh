zi_config="${XDG_CONFIG_HOME:-${HOME}/.config}/zi"
command mkdir -p "${zi_config}"
curl -fsSL https://git.io/zi-loader -o "${zi_config}/init.zsh"
