#!/usr/bin/env/zsh

### Added by ZI's installer
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}ZI%F{220} Initiative Plugin Manager (%F{33}z-shell/zi%F{220})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
### End of ZI's installer chunk

#####################
# PROMPT            #
#####################
zi lucid for \
  as"command" from"gh-r" atinit'export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"' atload'eval "$(starship init zsh)"' bpick'*unknown-linux-gnu*' \
  starship/starship \


##########################
# OMZ Libs and Plugins   #
##########################

# IMPORTANT:
# Ohmyzsh plugins and libs are loaded first as some these sets some defaults which are required later on.
# Otherwise something will look messed up
# ie. some settings help zsh-autosuggestions to clear after tab completion

setopt promptsubst

# Explanation:
# - Loading tmux first, to prevent jumps when tmux is loaded after .zshrc
# - History plugin is loaded early (as it has some defaults) to prevent empty history stack for other plugins
zi lucid for \
atinit"
  ZSH_TMUX_FIXTERM=true
  ZSH_TMUX_AUTOSTART=true
  ZSH_TMUX_AUTOCONNECT=true
" \
OMZP::tmux \
atinit"HIST_STAMPS=dd.mm.yyyy" \
OMZL::history.zsh \


zi wait lucid for \
OMZL::clipboard.zsh \
OMZL::compfix.zsh \
OMZL::completion.zsh \
OMZL::correction.zsh \
  atload"
  alias ..='cd ..'
  alias ...='cd ../..'
  alias ....='cd ../../..'
  alias .....='cd ../../../..'
  " \
OMZL::directories.zsh \
OMZL::git.zsh \
OMZL::grep.zsh \
OMZL::key-bindings.zsh \
OMZL::spectrum.zsh \
OMZL::termsupport.zsh \
  atload"
  alias gcd='gco dev'
  " \
OMZP::git \
OMZP::fzf \
  atload"
  alias dcupb='docker-compose up --build'
  " \
OMZP::docker-compose \
as"completion" \
  OMZP::docker/_docker \
  djui/alias-tips \
  # hlissner/zsh-autopair \
  # chriskempson/base16-shell \

#####################
# PLUGINS           #
#####################
# @source: https://github.com/crivotz/dot_files/blob/master/linux/zplugin/zshrc

# IMPORTANT:
# These plugins should be loaded after ohmyzsh plugins

zi wait lucid for \
light-mode from"gh-r" as"program" \
  junegunn/fzf-bin \
light-mode atinit"ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20" atload"_zsh_autosuggest_start" \
  zsh-users/zsh-autosuggestions \
light-mode atinit"typeset -gA FAST_HIGHLIGHT; FAST_HIGHLIGHT[git-cmsg-len]=100; zicompinit; zicdreplay;" \
  z-shell/F-Sy-H \
light-mode blockf atpull'zi creinstall -q .' \
atinit"
  zstyle ':completion:*' completer _expand _complete _ignored _approximate
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
  zstyle ':completion:*' menu select=2
  zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
  zstyle ':completion:*:descriptions' format '-- %d --'
  zstyle ':completion:*:processes' command 'ps -au$USER'
  zstyle ':completion:complete:*:options' sort false
  zstyle ':fzf-tab:complete:_zlua:*' query-string input
  zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm,cmd -w -w'
  zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
  zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always ${~ctxt[hpre]}$in'" \
  zsh-users/zsh-completions \
bindmap"^R -> ^H" atinit"
  zstyle :history-search-multi-word page-size 10
  zstyle :history-search-multi-word highlight-color fg=red,bold
  zstyle :plugin:history-search-multi-word reset-prompt-protect 1" \
  z-shell/H-S-MW \
reset \
atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}${P}sed -i '/DIR/c\DIR 38;5;63;1' LS_COLORS; ${P}dircolors -b LS_COLORS > c.zsh" \
atpull'%atclone' pick"c.zsh" nocompile'!' atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”' \
  trapd00r/LS_COLORS

#####################
# PROGRAMS          #
#####################

zi wait'1' lucid light-mode for \
pick"z.sh" \
  knu/z \
as'command' atinit'export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"' pick"bin/n" \
  tj/n \
from'gh-r' as'command' atinit'export PATH="$HOME/.yarn/bin:$PATH"' mv'yarn* -> yarn' pick"yarn/bin/yarn" bpick'*.tar.gz' \
  yarnpkg/yarn


#####################
# Misc Stuff        #
#####################

zi is-snippet for \
if"[[ -f $HOME/.localrc  ]]" $HOME/.localrc
