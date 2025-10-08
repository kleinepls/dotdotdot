# [[ -r ~/znap/znap.zsh ]] ||
#     git clone --depth 1 -- \
#         https://github.com/marlonrichert/zsh-snap.git ~/znap
# source ~/znap/znap.zsh

DISABLE_MAGIC_FUNCTIONS="true"

eval "$(starship init zsh)"
eval "$(~/.local/bin/mise activate zsh)"

autoload -U compinit; compinit
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.zshenv
source ~/.zsh_profile

bindkey -s ^f 'tmux-sessionizer\n'

bindkey '^[[1;5C' forward-word # <c-right>
bindkey '^[[1;5D' backward-word # <c-left>
bindkey '^[[1~' beginning-of-line # <c-home>
bindkey '^[[4~' end-of-line # <c-end>

setopt autocd
setopt SHARE_HISTORY

export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' fzf-flags --bind ctrl-f:half-page-down,ctrl-b:half-page-up
export FZF_DEFAULT_OPTS="--bind 'ctrl-f:half-page-down,ctrl-b:half-page-up'"

# export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

