export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


nvm use v16.15.1

source ~/.private.zshrc
source ~/.aliases.zshrc
source ~/.branch.zshrc
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# bun completions
[ -s "/Users/duncanvankeulen/.bun/_bun" ] && source "/Users/duncanvankeulen/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/duncanvankeulen/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
