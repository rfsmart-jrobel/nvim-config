eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

alias gs="git status && git log -1"
alias gl="git log -1"
alias gcm="git checkout master && git pull"

# Use the # symbol to comment out these lines if using browser based auth
export SUITECLOUD_CI=1
export SUITECLOUD_CI_PASSKEY="qfuyzxkcwboheaidrtnsmjglpvqfuykcwboheartnsidmjlpgoshnetra"

export JIRA_API_TOKEN="replaceme"
export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init zsh)"
