if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# ZSH option

## history setting
setopt HIST_IGNORE_ALL_DUPS HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS INC_APPEND_HISTORY

## pushd and other
setopt PUSHD_IGNORE_DUPS AUTO_PUSHD AUTO_LIST INTERACTIVE_COMMENTS AUTO_CD

## completion settings - pretty print - ignore case
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' rehash true

# exports

## faster startup, but less safer
export ZSH_DISABLE_COMPFIX="true"

## LS color, defined esp. for cd color, 'cause exa has its own setting
export CLICOLOR=1
export LSCOLORS=ExGxFxdaCxDaDahbadeche

## needs Clash installed
export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890

## needs Secretive installed - https://github.com/maxgoedjen/secretive
export SSH_AUTH_SOCK=/Users/col/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

## brew install gnupg
export GPG_TTY=$(tty)

export LANG=en_US.UTF-8

## brew install llvm; delete if you are not macos
export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

## brew install openssl; delete if you are not macos
export PATH="/usr/local/opt/openssl@3/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@3/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@3/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@3/lib/pkgconfig"

# zi

## - zsh-aliases-exa: exa required
##
## - macos: only for macOS
##
## - git: git required
## 
## - brew: brew required
##
## - vscode 
##
##  brew install --cask visual-studio code
##  or ln -s /path/to/vscode /user/local/bin/code 
##  for example: ln -s "/Applications/Visual Studio Code.app/Contents/MacOS/Electron" /usr/local/bin/code

zi wait lucid light-mode depth"1" for \
  atinit"ZI[COMPINIT_OPTS]=-C;" \
    z-shell/F-Sy-H \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  pick"z.sh" \
    z-shell/z \
  compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh' atload" \
    PURE_PROMPT_SYMBOL='λ';" \
    sindresorhus/pure \
  as'completion' atload'zicompinit; zicdreplay; def_lazyloads' \
    zsh-users/zsh-completions \
  multisrc="{directories,functions}.zsh" pick"/dev/null" \
    Colerar/omz-extracted \
  svn \
    https://github.com/ohmyzsh/ohmyzsh/trunk/plugins/macos \
  as"completion" blockf \
    https://raw.githubusercontent.com/Colerar/Tracks/cli/completions/_tracks \
  https://gist.githubusercontent.com/Colerar/2f23c76583ac7866a50cda5bb04ff3a4/raw/sha-alias.plugin.zsh \
  Colerar/zsh-aliases-exa \
  OMZL::git.zsh \
  OMZL::key-bindings.zsh \
  OMZP::git \
  OMZP::brew \
  OMZP::autojump \
  OMZP::vscode

PS1=`print "%F{magenta}λ%f "`

# functions

## jenv
## brew install jenv
eval export PATH="$HOME/.jenv/shims:${PATH}"

# 0.1 s faster
__lazyload_jenv() {
  unfunction __lazyload_jenv
  export JENV_SHELL=zsh
  export JENV_LOADED=1
  unset JAVA_HOME
  source '/usr/local/Cellar/jenv/0.5.4/libexec/completions/jenv.zsh'
  jenv rehash 2>/dev/null
  jenv refresh-plugins
}

jenv() {
  __lazyload_jenv()
  typeset command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  enable-plugin|rehash|shell|shell-options)
    eval `jenv "sh-$command" "$@"`;;
  *)
    command jenv "$command" "$@";;
  esac
}

function def_lazyloads() {
  unfunction def_lazyloads

  # gh: Colerar/tracks
  function __lazyload_tracks_completion() {
    [[ -e ~/.zi/completions/_tracks ]] && source ~/.zi/completions/_tracks
  }

  compdef __lazyload_tracks_completion tracks
}

# Alias

alias rm='move1(){ /bin/mv -f $@ ~/.trash/; };move1 $@'

alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'

emptytrash() {
  sudo /bin/rm -rf ~/.trash/*
}

alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
alias -s zshrc=vi
alias -s zsh=zsh
alias gcid="git rev-parse --short HEAD | pbcopy"

alias tracksub="tracks dig -so -ze -zt China"
