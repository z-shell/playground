if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source <(curl -sL https://init.zshell.dev); zzinit
zi ice atinit'COMPLETION_WAITING_DOTS=true'
zi snippet OMZL::completion.zsh
zi ice wait'0' lucid
zi light dominik-schwabe/vi-mode.zsh
zi ice wait'!0' lucid
zi light ~/.shell_plugins/asdf
zi ice wait'0' lucid
zi snippet OMZP::git
zi ice wait'0' lucid
zi snippet OMZP::pip
zi ice wait'0' lucid
zi light agkozak/zsh-z
zi ice wait'0' lucid
zi light t413/zsh-background-notify
zi ice wait'0' lucid
zi light zsh-users/zsh-history-substring-search
zi ice wait'0' lucid
zi light zsh-vi-more/vi-increment
zi ice wait'0' lucid
zi light zdharma-continuum/fast-syntax-highlighting
zi ice wait'0' lucid
zi light MichaelAquilina/zsh-you-should-use
zi ice wait'0' lucid silent atinit'ZSH_SYSTEM_CLIPBOARD_TMUX_SUPPORT=true'
zi light kutsan/zsh-system-clipboard
zi ice wait'0' lucid atload'zicompinit'
zi light zsh-users/zsh-completions
zi snippet 'https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh'

[[ -z "$LS_COLORS" ]] && (( $+commands[dircolors] )) && eval "$(dircolors -b)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

## use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

ls_on() {
    chpwd() {
        emulate -L zsh
        ls
    }
}

ls_off() {
    chpwd() { }
}

ls_on

unset correctall

# theme
DEFAULT_COLOR="2"
ROOT_COLOR="161"
SSH_COLOR="214"

PROMPT_COLOR=${DEFAULT_COLOR:-green}
[[ "$UID" = "0" ]] && PROMPT_COLOR=${ROOT_COLOR:-red}
[[ "$SSH_TTY" ]] && PROMPT_COLOR=${SSH_COLOR:-blue}

git_prompt_info() {
    if ref=$(git symbolic-ref HEAD 2>&1); then
        branch=${ref#refs/heads/}
        if [[ "$branch" = "master" || "$branch" = "main" ]]; then
            echo " %F{1}$branch%f"
        else
            echo " %F{3}$branch%f"
        fi
    else
        [[ "$ref" = 'fatal: ref HEAD is not a symbolic ref' ]] && echo " %F{14}no branch%f"
    fi
}
PROMPT='%B%F{'$PROMPT_COLOR'}%n%f%F{7}@%F{'$PROMPT_COLOR'}%m %F{blue}%2~%f%B$(git_prompt_info)%b%b >>> '

declare -u _GET_ASDF_VERSION_VARIABLE_NAME
_get_asdf_versions_prompt() {
    _GET_ASDF_VERSION_VARIABLE_NAME=ASDF_$1_VERSION
    if DEFINED_NAME=$(export -p "$_GET_ASDF_VERSION_VARIABLE_NAME") 2>/dev/null && [[ "$DEFINED_NAME" = 'export'* ]]; then
        eval "_VERSIONS=\$$_GET_ASDF_VERSION_VARIABLE_NAME"
        [[ -n "$_VERSIONS" ]] && {
            echo "$_VERSIONS"
            return 0
        }
    fi
    [[ -r ~/.tool-versions ]] || return 1
    while read LINE; do
        IFS=" " read _ASDF_PROG_NAME _ASDF_PROG_VERSION <<< $LINE;
        if [[ "$_ASDF_PROG_NAME" = $1 ]]; then
            echo "$_ASDF_PROG_VERSION"
            return 0
        fi
    done < "$HOME/.tool-versions"
    return 1
}

get_python_version() { _get_asdf_versions_prompt python || echo system }
get_node_version() { _get_asdf_versions_prompt nodejs || echo system }
RPS1='%(?..%F{1}%B%?%b%f )% %w %B%F{11}%T%f%b%F{9}%B $(get_python_version)%b%f%F{34}%B $(get_node_version)%b%f'
# theme end

setopt hist_ignore_dups hist_ignore_space interactivecomments noextendedhistory nosharehistory auto_cd multios prompt_subst histignorealldups

exit_zsh() { exit }
zle -N exit_zsh
bindkey -M viins '^D' exit_zsh
bindkey -M vicmd '^D' exit_zsh

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

expand-alias() { zle _expand_alias }
zle -N expand-alias
bindkey -M viins '^[OS' expand-alias
bindkey -M vicmd '^[OS' expand-alias

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

bindkey -r -M vicmd '\ec'
bindkey -r -M viins '\ec'

bindkey -M vicmd '^P' fzf-cd-widget
bindkey -M viins '^P' fzf-cd-widget
