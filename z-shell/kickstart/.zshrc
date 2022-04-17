# ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ❮ Z-SHELL ❯ ❮ ZI ❯
[[ ! -r "${HOME}/.config/zi/init.zsh" ]] \
&& { sh -c "$(curl -fsSL https://git.io/get-zi)" -- -a loader && exec zsh }
source "${HOME}/.config/zi/init.zsh" && zzinit
zi for z-shell/z-a-meta-plugins @annexes skip'peko skim fzy' @fuzzy \
  skip'hexyl hyperfine vivid tig' @console-tools birdhackor/zsh-exa-ls-plugin
zi-turbo '0b' is-snippet for has'svn' svn atinit'HISTFILE="${HOME}/.cache/zhistory"' \
  pick"completion.zsh" multisrc'git.zsh functions.zsh \
  {prompt_info_functions,history,grep}.zsh' OMZ::lib \
  has'git' atload"unalias grv g" OMZP::git
zi for skip'F-Sy-H' @z-shell @zsh-users+fast \
MichaelAquilina/zsh-you-should-use skip'git-extras' @ext-git @romkatv
[[ ! -f "${HOME}/.p10k.zsh" ]] && p10k configure
