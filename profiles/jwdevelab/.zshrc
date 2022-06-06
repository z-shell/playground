if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
if [[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/zi/init.zsh" ]]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}/zi/init.zsh" && zzinit
fi

# ================================================================================================= #
[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor
auto-exa () { exa ${exa_params}; }
[[ ${chpwd_functions[(r)auto-exa]} == auto-exa ]] || chpwd_functions=( auto-exa $chpwd_functions )
# ================================================================================================= #
# setopt
setopt hist_ignore_all_dups     # Remove older duplicate entries from history
setopt hist_expire_dups_first   # Expire A Duplicate Event First When Trimming History.
setopt hist_ignore_dups         # Do Not Record An Event That Was Just Recorded Again.
setopt hist_reduce_blanks       # Remove superfluous blanks from history items
setopt hist_find_no_dups        # Do Not Display A Previously Found Event.
setopt hist_ignore_space        # Do Not Record An Event Starting With A Space.
setopt hist_save_no_dups        # Do Not Write A Duplicate Event To The History File.
setopt hist_verify              # Do Not Execute Immediately Upon History Expansion.
setopt promptsubst
# zstyle
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' rehash true
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR
# ================================================================================================= #
fpath+=( $ZDOTDIR/zsh/functions )
autoload -Uz mem setoptt whichcomp palette colormap

zi is-snippet for svn \
  pick"completion.zsh" multisrc'git.zsh functions.zsh \
  {prompt_info_functions,clipboard,termsupport,history,grep}.zsh' OMZ::lib

zi is-snippet for OMZP::ssh-agent OMZP::gpg-agent OMZP::sudo \
  OMZP::encode64 OMZP::extract \
    atload'zstyle ":completion:*" special-dirs false' PZTM::completion \

zi light-mode for z-shell/z-a-meta-plugins @annexes \
    skip'fzy' @fuzzy skip'tig' @console-tools skip'F-Sy-H' @z-shell

zi light-mode for \
    birdhackor/zsh-exa-ls-plugin \
    MichaelAquilina/zsh-you-should-use @zsh-users+fast @romkatv

zicompinit
zi snippet "$ZDOTDIR/aliases/aliases.zsh"
zi snippet "$ZDOTDIR/bindmap/bindkeys.zsh"
zi snippet "$ZDOTDIR/.p10k.zsh"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.zi/snippets/home--jwdev--.config--zsh/.p10k.zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.zi/snippets/home--jwdev--.config--zsh/.p10k.zsh/.p10k.zsh ]] || source ~/.config/zsh/.zi/snippets/home--jwdev--.config--zsh/.p10k.zsh/.p10k.zsh

