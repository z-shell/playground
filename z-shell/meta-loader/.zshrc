if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
if [[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/zi/init.zsh" ]]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}/zi/init.zsh" && zzinit
fi
setopt promptsubst
module_path+=( /home/z-shell/.zi/zmodules/zpmod/Src )
zmodload zi/zpmod 2> /dev/null

zi-turbo '0a' is-snippet for svn atinit'HISTFILE="${HOME}/.cache/zi/history"' \
  pick"completion.zsh" multisrc'git.zsh functions.zsh \
  {prompt_info_functions,history,grep}.zsh' OMZ::lib

zi-turbo '0b' light-mode for atload"unalias grv g" OMZP::git OMZP::sudo OMZP::extract \
  MichaelAquilina/zsh-you-should-use birdhackor/zsh-exa-ls-plugin z-shell/zsh-unique-id \
  atload'zstyle :zi:annex:test quiet 0' z-shell/z-a-test atload"zsh-startify" z-shell/zsh-startify

zi for z-shell/z-a-meta-plugins @annexes skip'fzy' @fuzzy skip'tig' @console-tools \
  skip'git-extras' @ext-git @romkatv skip'F-Sy-H' @z-shell @zsh-users+fast @zunit

if (( $+commands[vivid] )) { LS_COLORS="$(vivid generate solarized-light)" }
if (( $+commands[exa] )) { auto-exa () { exa ${exa_params}; }; [[ ${chpwd_functions[(r)auto-exa]} == auto-exa ]] || chpwd_functions=( auto-exa $chpwd_functions ) }
