# [[ -r ~/znap/znap.zsh ]] ||
#     git clone --depth 1 -- \
#         https://github.com/marlonrichert/zsh-snap.git ~/znap
# source ~/znap/znap.zsh

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

eval "$(starship init zsh)"
eval "$(~/.local/bin/mise activate zsh)"

bindkey -s ^f 'tmux-sessionizer\n'

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

source ~/.zshenv
source ~/.zsh_profile

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

