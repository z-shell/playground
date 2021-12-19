if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
if [[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/zi/init.zsh" ]]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}/zi/init.zsh" && zzinit
fi

zi-turbo '0a' for OMZL::git.zsh atload"unalias grv g" OMZP::git
zi cdclear -q

zi-turbo '0b' for OMZL::compfix.zsh OMZL::clipboard.zsh OMZL::functions.zsh \
OMZL::completion.zsh OMZL::directories.zsh OMZL::spectrum.zsh OMZL::termsupport.zsh 
OMZL::prompt_info_functions.zsh

zi-turbo '0c' light-mode for OMZP::sudo OMZP::extract OMZP::encode64 OMZP::colorize OMZP::grc

zi light-mode for z-shell/z-a-meta-plugins @annexes skip'fzy' @fuzzy skip'tig exa' @console-tools \
@zsh-users+fast skip'F-Sy-H' @z-shell ext-git

zi light-mode for @romkatv
