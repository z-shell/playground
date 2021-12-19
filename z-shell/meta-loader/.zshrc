if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
if [[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/zi/init.zsh" ]]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}/zi/init.zsh" && zzinit
fi
zi-turbo '0a' light-mode for OMZL::git.zsh \
  OMZL::compfix.zsh OMZL::prompt_info_functions.zsh \
  OMZL::spectrum.zsh OMZL::clipboard.zsh OMZL::functions.zsh \
  OMZL::completion.zsh OMZL::termsupport.zsh OMZL::directories.zsh
zi-turbo '0b' light-mode for atload"unalias grv g" \
  OMZP::git OMZP::sudo OMZP::extract OMZP::encode64 OMZP::colorize
zi light-mode for z-shell/z-a-meta-plugins @annexes \
  skip'fzy' @fuzzy skip'tig' @console-tools skip'git-extras' @ext-git @romkatv \
  skip'F-Sy-H' @z-shell @zsh-users+fast zpm-zsh/ls MichaelAquilina/zsh-you-should-use