### Added by Zinit's installer
source ~/.zi/bin/zi.zsh
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
### End of Zinit installer's chunk

##### BEGIN Zinit stuff #####
### needs: zi, fzf

# z
zi ice wait blockf lucid
zi light rupa/z

# z tab completion
zi ice wait lucid
zi light changyuheng/fz

# z / fzf (ctrl-g)
zi ice wait lucid
zi light andrewferrier/fzf-z

# cd
zi ice wait lucid
zi light changyuheng/zsh-interactive-cd

# Don't bind these keys until ready
bindkey -r '^[[A'
bindkey -r '^[[B'
function __bind_history_keys() {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
}
# History substring searching
zi ice wait lucid atload'__bind_history_keys'
zi light zsh-users/zsh-history-substring-search

# autosuggestions, trigger precmd hook upon load
zi ice wait lucid atload'_zsh_autosuggest_start'
zi light zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=10

# Tab completions
zi ice wait lucid blockf atpull'zi creinstall -q .'
zi light zsh-users/zsh-completions

# Syntax highlighting
zi ice wait lucid atinit'zicompinit; zicdreplay'
zi light z-shell/F-Sy-H

##### END Zinit stuff #####
