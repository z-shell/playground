# ================================================================================================================== #
# ➜ ➜ ➜ (c) 2022 Z-Shell || ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■                      ❮ ZI ❯
# ================================================================================================================== #
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi; source <(curl -sL https://init.zshell.dev); zzinit
# PRESET ============================================================================================================ #
local ZSH_AUTOSUGGEST_USE_ASYNC=true
local ZSH_AUTOSUGGEST_MANUAL_REBIND=1
local ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
local ZSH_AUTOSUGGEST_STRATEGY=(history completion)
setopt octal_zeroes no_prompt_cr no_always_to_end list_packed complete_in_word no_auto_menu
setopt numeric_glob_sort no_glob_dots c_bases rc_quotes extendedglob notify no_glob_complete promptsubst
# ALIASES & COMPLETIONS ============================================================================================= #
zi is-snippet for as"completion" blockf \
  https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
# ANNEX ============================================================================================================= #
zi light-mode for z-shell/z-a-unscope meta atinit'zstyle :zi:annex:test quiet 0;' z-shell/z-a-test
# META-PLUGINS ===================================================================================================== #
zi for @annexes @zsh-users+fast \
    skip'fzy' @fuzzy @zunit @romkatv \
    skip'F-Sy-H' @z-shell @ext-git \
    skip'
    dircolors-material
      hyperfine
        ripgrep
          vivid
            hexyl
              peco
                tig 
                  bat 
                    fd' @console-tools
# OH-MY-ZSH LIBRARY ================================================================================================= #
array=({git,functions,history,completion,prompt_info_functions,grep,completion,vcs_info}.zsh)
zi-turbo '0a' is-snippet for has'svn' svn multisrc'$array' pick'/dev/null' \
  atinit'HISTFILE=${HOME}/.cache/zi/zsh-history;
         COMPLETION_WAITING_DOTS=true' OMZ::lib
# OH-MY-ZSH PLUGINS ================================================================================================= #
zi-turbo '0b' is-snippet for atload"unalias grv g" OMZP::git \
  atload'zstyle ":completion:*" special-dirs false' \
    pzcomp
# PLUGINS =========================================================================================================== #
zi-turbo '0c' for has'exa' atinit'AUTOCD=1' zplugin/zsh-exa \
    MichaelAquilina/zsh-you-should-use
zi-turbo '0d' for atinit'zstyle :plugin:zuid codenames ion proxima falcon oblivion' \
    z-shell/zsh-unique-id zui zbrowse \
    z-shell/ztrace \
    z-shell/z-a-eval
autoload -Uz compinit
compinit
zi cdreplay -q

[[ ! -f "${HOME}/.p10k.zsh" ]] && p10k configure
    
