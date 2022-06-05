# ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ❮ Z-SHELL ❯ ❮ ZI ❯
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source <(curl -sL https://init.zshell.dev); zzinit
zi for z-shell/z-a-meta-plugins @annexes \
  skip'hexyl hyperfine vivid tig' @console-tools \
  skip'peko skim fzy' @fuzzy \
  skip'git-extras' @ext-git @romkatv \
  skip'F-Sy-H' @z-shell @zsh-users+fast
array=({git,functions,history,completion,prompt_info_functions,grep,completion,vcs_info}.zsh)
zi-turbo '0a' lucid is-snippet for has'svn' svn multisrc'$array' pick'/dev/null' \
  atinit'HISTFILE=${HOME}/.cache/zi/zsh-history; COMPLETION_WAITING_DOTS=true' \
    OMZ::lib
zi-turbo '0b' lucid is-snippet for \
  atload"unalias grv g" \
    OMZP::git
zi-turbo '0c' lucid light-mode for MichaelAquilina/zsh-you-should-use \
  atinit'ZSH_SYSTEM_CLIPBOARD_TMUX_SUPPORT=true' \
    kutsan/zsh-system-clipboard \
  atinit'AUTOCD=1' \
    zplugin/zsh-exa

[[ ! -f "${HOME}/.p10k.zsh" ]] && p10k configure
