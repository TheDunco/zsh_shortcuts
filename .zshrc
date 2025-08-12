# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# Q pre block. Keep at the top of this file.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#customization for zsh shell

#bat installed for colorful cat ouput. To make it run with cat command do alias cat.
#Here By default, bat pipes its own output to a pager (e.g less) if the output is too large for one screen. If you would rather bat work like cat all the time (never page output), you can set --paging=never.
export BAT_THEME='gruvbox-dark'

# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Bun
export BUN_INSTALL="/Users/duncanvankeulen/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="/opt/homebrew/bin:$PATH"

# bun completions
[ -s "/Users/duncanvankeulen/.bun/_bun" ] && source "/Users/duncanvankeulen/.bun/_bun"

# Always have code in path
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

source ~/.private.zshrc
source ~/.aliases.zshrc

# pnpm
export PNPM_HOME="/Users/duncanvankeulen/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# zoxide
eval "$(zoxide init zsh)"

# Make sure the 1Password biometric unlock is enabled
export OP_BIOMETRIC_UNLOCK_ENABLED=true

# Set the tab name as the current directory
# With prefix
# precmd () {print -Pn "\e]0;%n@%m: %~\a"}
# Without prefix
precmd () {print -Pn "\e]0;%~\a"}

[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"

# Q post block. Keep at the bottom of this file.
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/duncanvankeulen/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/duncanvankeulen/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/duncanvankeulen/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/duncanvankeulen/google-cloud-sdk/completion.zsh.inc'; fi

# v22
nvm use v22.14.0

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
