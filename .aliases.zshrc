BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT_GRAY='\033[0;37m'
DARK_GRAY='\033[1;30m'
LIGHT_RED='\033[1;31m'
LIGHT_GREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHT_BLUE='\033[1;34m'
LIGHT_PURPLE='\033[1;35m'
LIGHT_CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

# Git
alias status='echo -e "\t📈\t📊\t📊\t📊\t📉" && git status'
alias stat='status'
alias statsu='status'
alias stast='status'
alias stuats='status'
alias stauts='status'
alias stuats='status'
alias log='git log'
alias diff='git diff'
alias branch='git branch'
alias br='branch'
alias merge='git merge'
alias rebase='git rebase'
alias push='git push --set-upstream origin $(cb) && status'
alias uncommit='git reset --soft HEAD~1'
function checkout() {
    git checkout $1
}
alias chk='checkout' 
alias fileschanged="git diff --name-only main $(git rev-parse --abbrev-ref HEAD) | grep -o '[^/]*$'"

# PNPM
alias pn='pnpm'
alias pnx='pnpm dlx'
alias storefront='pn --filter storefront'
alias store='storefront'
alias admin='pn --filter admin'
alias server='pn --filter admin-server'
alias cms='pn --filter cms'
alias pigeon='pn --filter pigeon'
alias support='pn --filter support'
alias aw='pn --filter admin-web'
alias utils='pn --filter utils'
alias lintall='time pnpm --parallel -r lint --fix'
alias lint-inspect='pnpm dlx @eslint/config-inspector@latest'
alias i="pnpm i && notify 'Installation Finished' 'pnpm'"

export PNPM_STORE_PATH="/Users/duncanvankeulen/Library/pnpm/store/v3"
alias clearpncache='pnpm store prune && rm -rf $PNPM_STORE_PATH && echo -e "${GREEN}✅ Cleared pnpm cache${NC}"'

# Custom functions
function typecheck() {
    echo -e "${ORANGE}✔️ Running type-check..." && \
    pn type-check && \
    echo -e "${GREEN}✅ Type-check ran successfully!${NC}" || \
    echo -e "${RED}❌ Type-check failed!${NC}"
}

function branchrm-local() {
    git branch -D $1 && \
    echo -e "${GREEN}✅ Deleted local branch ${LIGHT_BLUE}${BOLD}$1${NC}${NORMAL}" || \
    echo -e "${RED}❌ Could not delete local branch ${BOLD}$1${NC}${NORMAL}"
}

function branchrm-remote() {
    git push origin --delete $1 && \
    echo -e "${GREEN}✅ Deleted local branch ${LIGHT_BLUE}${BOLD}$1${NC}${NORMAL}" || \
    echo -e "${RED}❌ Could not delete local branch ${BOLD}$1${NC}${NORMAL}"
}

function branchprune() {
    git fetch --all --prune && \
    echo -e "${GREEN}✅ Pruned branches${NC}" || \
    echo -e "${RED}❌ Could not prune branches${NC}"
}

function restore() { 
    git restore $1 && \
    echo -e "⏪ ${CYAN}Restored ${LIGHT_BLUE}${BOLD}$1${NORMAL}${NC}" || \
    echo -e "Could not restore $1"
    status
}

function unstage() {
    git restore --staged $1 && \
    status && \
    echo -e "${CYAN}➖ Unstaged ${LIGHT_BLUE}${BOLD}$1${NC}${NORMAL}" || \
    echo -e "${RED}❌ Could not unstage ${BOLD}$1${NC}${NORMAL}"
}

# Commit git changes with message
function commit() {
    git commit -m "$1" && \
    status && \
    echo -e "${GREEN}✅ Commit successful! Message: ${LIGHT_CYAN}${BOLD}$1${NORMAL}${NC}" || \
    echo -e "${RED}❌ Commit failed!${NC}"
}

# Fast commit: commit and push changes with message
function fcommit() {
    git commit -m "$1" && \
    status && \
    push && \
    echo -e "${GREEN}✅ Fast commit successful! Message: ${LIGHT_CYAN}${BOLD}$1${NORMAL}${NC}" || \
    echo -e "${RED}❌ Fast commit failed!${NC}"
}

function mcomm() {
  fcommit $@
}

alias lintr='pn -r lint --fix'

function lcomm() {
  add . && lintr && add . && fcommit $@
}

# Add, commit, and push changes with message
function acommit() {
    git commit -am "$1" && \
    status && \
    push && \
    echo -e "${GREEN}✅ Add commit successful! Message: ${LIGHT_CYAN}${BOLD}$1${NORMAL}${NC}" || \
    echo -e "${RED}❌ Add commit failed!${NC}"
}

# Safe/stepped commit with message
function scommit() {
    type-check && \
    status && \
    echo -e "${PURPLE}Everything look ok?${NC}" && \
    diff && \
    git commit -am "$1" && \
    status && \
    push && \
    echo -e "${GREEN}✅ Commit successful! Message: ${LIGHT_CYAN}${BOLD}$1${NORMAL}${NC}" || \
    echo -e "${RED}❌ Commit failed!${NC}"
}

# Save the current git branch for use within these aliases
alias cb='git rev-parse --abbrev-ref HEAD'

function cho() {
    status && \
    git checkout $@ && \
    echo -e "🕊 Switched to branch ${LIGHT_BLUE}${BOLD}$(cb)${NC}${NORMAL}" && \
    status && \
    echo -e "${GREEN}✅ Successfully switched to ${LIGHT_BLUE}${BOLD}$(cb)${NORMAL}${NC}" || \
    echo -e "${REG}❌ Could not switch to ${LIGHT_BLUE}${BOLD}$(cb)${NORMAL}${NC}"
}

function add() {
    git add $1
    status
    echo -e "${CYAN}➕ Added ${BOLD}$1${NC}${NORMAL}" || \
}

function process() {
    ps -ax | grep $1
}

function proc() {
    process $1
}

# Can follow with `kill -3 <PID>` to kill process occupying port
function portls() {
    lsof -i :$1
}

function softreset() {
    echo -e "${CYAN}🔄 Resetting to ${LIGHT_BLUE}${BOLD}$(cb)${NC}${NORMAL}" && \
    git reset --soft HEAD~1 && \
    status && \
    echo -e "${GREEN}✅ Successfully reset to ${LIGHT_BLUE}${BOLD}$(cb)${NORMAL}${NC}" || \
    echo -e "${RED}❌ Could not reset to ${LIGHT_BLUE}${BOLD}$(cb)${NORMAL}${NC}"
}

function hardreset() {
    echo -e "${CYAN}🔄 Resetting to ${LIGHT_BLUE}${BOLD}$(cb)${NC}${NORMAL}" && \
    git reset --hard HEAD~1 && \
    status && \
    echo -e "${GREEN}✅ Successfully reset to ${LIGHT_BLUE}${BOLD}$(cb)${NORMAL}${NC}" || \
    echo -e "${RED}❌ Could not reset to ${LIGHT_BLUE}${BOLD}$(cb)${NORMAL}${NC}"
}

alias fetch='git fetch'
alias pull='git pull origin $(cb) && echo -e "${GREEN}⬇️ Pulled ${LIGHT_BLUE}$(cb)${NC}" || echo -e "${RED}❌ Could not pull ${NC}"'

function fpush() {
    status && add . && git commit -m $1 && git push && status
}

alias type-check='typecheck'

# Clearing node_modules, lockfiles, and caches.
alias nodeclear='rm -rf node_modules package-lock.json && echo -e "${GREEN}✅ Cleared node_modules and package-lock.json${NC}"'

alias cloudtunnel='cloudflared tunnel --url http://localhost:3000'
alias cmstunnel='cloudflared tunnel --url http://localhost:3002'

# These were for trying to get local mongo to work without docker
alias mongod='brew services run mongodb-community'
alias mongod-status='brew services list'
alias mongod-stop='brew services stop mongodb-community'

# Clipboard (doesn't work super well)
alias clip='pbcopy'
alias copy='pbcopy'
alias paste='pbpaste'
alias reload='source ~/.zshrc && echo -e "${PURPLE}🔄 Sourced .zshrc${NC}"'
alias rl='reload'

# Quick file finding and zipping
alias f='fzf | tr -d "\n\r[:blank:]" | copy'
alias zp='cd $(dirname $(paste) ) && pwd'
alias zpnv='nvim $(paste)'

# Cypress and copying
alias cyp='pn cypress'
alias cyp-headless='pn cypress:run'
alias cyp-proxy='pn cal-proxy'
alias local-proxy='pn cal-proxy'
alias loc-prox='pn cal-proxy'
alias prox='npx localtunnel --port 3000 --subdomain theduncolocaldev'

alias dev='echo -e "${ORANGE}Running development server..." && pn dev'

alias addalias='f() { echo '\nalias "$1"' >> ~/.aliases.zshrc && reload };f'
alias editaliases='nvim ~/.aliases.zshrc'
alias ll='ls -Flags'

alias utest='pn test -- -u'

function prc() {
    # gh pr create -B main -d -t "$(git rev-parse --abbrev-ref HEAD): $1" -b "$(cat /Users/duncanvankeulen/dev/commerce/.github/pull_request_template.md)"
    gh pr create -B main -d -t "$1" -b "$(cat /Users/duncanvankeulen/dev/commerce/.github/pull_request_template.md)"
}

alias nb='git checkout -b $1'

alias vim='nvim'

alias adbrev='adb devices && adb -s emulator-5554 reverse tcp:4242 tcp:4242 && adb reverse --list'

alias rw='pn railway'

alias rebuildtypes='pn --filter types prepare'
alias rbtypes='rebuildtypes'

alias kittyconfig='nvim ~/.config/kitty/kitty.conf'
alias kittyconf='kittyconfig'
alias ghosttyconf='nvim ~/Library/Application\ Support/com.mitchellh.ghostty/config'
alias kittyshortcuts='nvim ~/.config/kitty/shortcuts.md'
alias icat="kitten icat"

alias lspconfig='nvim ~/.config/nvim/lua/configs/lspconfig.lua'

alias nv='node --version'

function imgcat() {
  kitten icat https://images.tekton.com/$1
}

function publishall() {
  z cli-scripts && pn run-ts commercetools/publish-staged-products.ts $@ && z -
}

function nvimconfig() {
  z ~/.config/nvim && nvim && z -
}

alias nvconf='nvimconfig'

alias 2='clear'
alias v='z commerce && nvim'

function notify() {
  osascript -e 'on run argv
    display notification (item 1 of argv) with title (item 2 of argv)
  end run' "$@"
}
alias pig-deploy-ct="pigeon cdk deploy Commercetools -e && notify 'Deploy Complete' 'Pigeon'"
