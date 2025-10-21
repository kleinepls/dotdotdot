# [[ -r ~/znap/znap.zsh ]] ||
#     git clone --depth 1 -- \
#         https://github.com/marlonrichert/zsh-snap.git ~/znap
# source ~/znap/znap.zsh

source ~/.zshenv
source ~/.zsh_profile

eval "$(starship init zsh)"
eval "$(~/.local/bin/mise activate zsh)"

autoload -U compinit; compinit
autoload -U history-search-end
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

bindkey -s ^f 'tmux-sessionizer\n'

bindkey "$terminfo[kcuu1]" history-beginning-search-backward
bindkey "$terminfo[kcud1]" history-beginning-search-forward

# <c-right|left> <home|end> <c-home|end>
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[1;5H' beginning-of-line
bindkey '^[[1;5F' end-of-line

DISABLE_MAGIC_FUNCTIONS="true"

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt share_history
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt autocd

export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' fzf-flags --bind ctrl-f:half-page-down,ctrl-b:half-page-up
export FZF_DEFAULT_OPTS="--bind 'ctrl-f:half-page-down,ctrl-b:half-page-up'"

# export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

