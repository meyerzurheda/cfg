# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# enable history plugins installed with brew
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias vim="nvim"
alias v="vim"
alias ls="eza --icons=always"
alias h=history

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

# fzf installation
source <(fzf --zsh)

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

JSII_SILENCE_WARNING_UNTESTED_NODE_VERSION=true

function production {
  export AWS_PROFILE=production
  eval "$(aws configure export-credentials --profile $AWS_PROFILE --format env)"
}
function staging {
  export AWS_PROFILE=staging
  eval "$(aws configure export-credentials --profile $AWS_PROFILE --format env)"
}

IGNOREEOF=2

export GOPRIVATE=github.com/baupal
export PATH=$PATH:$(go env GOPATH)/bin
