# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi


ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# history setup
HISTFILE=$HOME/.zhistory
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

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

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
