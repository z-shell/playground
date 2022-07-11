# .zshrc of 0xMRTT
# See https://github.com/0xMRTT/dotfiles/ for more

autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

typeset -A ZI

setopt hist_ignore_all_dups    
setopt hist_expire_dups_first  
setopt hist_ignore_dups        
setopt hist_reduce_blanks     
setopt hist_find_no_dups    
setopt hist_ignore_space   
setopt hist_save_no_dups      
setopt hist_verify          
setopt append_history     
setopt extended_history     
setopt inc_append_history   
setopt share_history         
setopt bang_hist            
setopt multios              
setopt interactive_comments 
setopt pushd_ignore_dups    
setopt auto_cd            
setopt no_beep              
setopt auto_list            
setopt auto_pushd          
setopt pushdminus          
setopt promptsubst          

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

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

zstyle ':completion:*' menu select

if [[ -r "/home/user/.config/zi/init.zsh" ]]; then
  source "/home/user/.config/zi/init.zsh" && zzinit
fi

zi light-mode for z-shell/z-a-meta-plugins @annexes @ext-git

zi ice lucid wait has'fzf'
zi light Aloxaf/fzf-tab

zi ice as"completion"
zi snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zi ice lucid wait as'completion' blockf has'cargo'
zi snippet https://github.com/rust-lang/cargo/blob/master/src/etc/_cargo

zi ice lucid wait as'completion' blockf has'youtube-dl' mv'youtube-dl.zsh -> _youtube-dl'
zi snippet https://github.com/ytdl-org/youtube-dl/blob/master/youtube-dl.plugin.zsh

zi ice lucid wait as'completion'
zi light zsh-users/zsh-completions

zi ice lucid wait as'completion' blockf pick'src/go' src'src/zsh'
zi light zchee/zsh-completions

zi ice lucid wait as'completion' blockf mv'git-completion.zsh -> _git'
zi snippet https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh

zi ice lucid wait as'program' from"gh-r" has'fzf'
zi light denisidoro/navi

zi ice lucid wait as'program' has'bat' pick'src/*'
zi light eth-p/bat-extras

zi ice svn pick"completion.zsh" src"git.zsh"
zi snippet OMZ::lib

zi lucid light-mode for pick"z.sh" z-shell/z

zi ice wait lucid has'fzf' pick'fzf-finder.plugin.zsh'
zi light leophys/zsh-plugin-fzf-finder

zi ice wait lucid atinit"ZI[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
zi light z-shell/F-Sy-H

zi ice wait lucid atload"!_zsh_autosuggest_start"
zi load zsh-users/zsh-autosuggestions

zi ice wait lucid atload"zsh-startify"
zi load z-shell/zsh-startify

zi ice wait lucid
zi load z-shell/zsh-navigation-tools

zstyle ":history-search-multi-word" page-size "11"
zi ice wait lucid
zi load z-shell/H-S-MW

zi ice wait lucid
zi load z-shell/zui

zi snippet OMZ::plugins/git/git.plugin.zsh
zi snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh
zi snippet OMZ::plugins/common-aliases/common-aliases.plugin.zsh
zi snippet OMZ::plugins/yarn/yarn.plugin.zsh
zi snippet OMZ::plugins/fzf/fzf.plugin.zsh
zi snippet OMZ::plugins/sudo/sudo.plugin.zsh


export PATH="$PATH:$HOME/bin"

export LS_COLORS="$(vivid generate molokai)"
alias ls="exa --icons"
alias c="clear"
#eval "$(zoxide init zsh)"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zi ice depth'1' atload"[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" nocd
# .p10k.zsh is available on https://github.com/0xMRTT/dotfiles/
zi light romkatv/powerlevel10k
