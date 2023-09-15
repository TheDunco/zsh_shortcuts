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

# PNPM
alias pn='pnpm'
alias storefront='pn --filter storefront'
alias store='storefront'
alias cms='pn --filter cms'

export PNPM_STORE_PATH="/Users/duncanvankeulen/Library/pnpm/store/v3"
alias clearpncache='pnpm store prune && rm -rf $PNPM_STORE_PATH && echo -e "${GREEN}✅ Cleared pnpm cache${NC}"'

# Custom functions
function typecheck() {
    echo -e "${ORANGE}✔️ Running type-check..." && \
    pn type-check && \
    echo -e "${GREEN}✅ Type-check ran successfully!${NC}" || \
    echo -e "${RED}❌ Type-check failed!${NC}"
}


function test() {
    echo -e "${ORANGE}🧪 Running jest tests in storefront" && \
    store test&& \
    echo -e "${ORANGE}✔️ Running type-check on individual projects..." && \
    cms type-check && \
    storefront type-check && \
    echo -e "${GREEN}✅ Tests ran successfully!${NC}" || \
    echo -e "${RED}❌ Tests failed!${NC}"
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

# Commit git changes
function commit() {
    test && \
    store type-check && \
    git commit -m "$1" && \
    status && \
    echo -e "${GREEN}✅ Commit successful! Message: ${LIGHT_CYAN}${BOLD}$1${NORMAL}${NC}" || \
    echo -e "${RED}❌ Commit failed!${NC}"
}

# Fast commit: commit and push changes
function fcommit() {
    test && \
    git commit -m "$1" && \
    status && \
    push && \
    echo -e "${GREEN}✅ Fast commit successful! Message: ${LIGHT_CYAN}${BOLD}$1${NORMAL}${NC}" || \
    echo -e "${RED}❌ Fast commit failed!${NC}"
}

# Add, commit, and push changes
function acommit() {
    test && \
    type-check && \
    git commit -am "$1" && \
    status && \
    push && \
    echo -e "${GREEN}✅ Add commit successful! Message: ${LIGHT_CYAN}${BOLD}$1${NORMAL}${NC}" || \
    echo -e "${RED}❌ Add commit failed!${NC}"
}

# Safe/stepped commit
function scommit() {
    test && \
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

function tests() {
    test && \
    type-check
}

function alltest() {
    test
    type-check
    cyp-headless
}

function remove() {
    echo -e "💰 Removing cached file/folder $1..."
    git rm -r --cached $1 && \
    status && \
    echo -e "${GREEN}➖ Removed ${LIGHT_BLUE}${BOLD}$1${NC}${NORMAL}" || \
    echo -e "${RED}❌ Could not remove ${BOLD}$1${NC}${NORMAL}"
}

# Reinstall node_modules and discard changes to package-lock.json
function renode() {
    echo "🗑  Removing node_modules and package-lock.json and .next..."
    rm -rf package-lock.json node_modules/ .next && \
    echo "☕️ Reinstalling packages..." && \
    npm i && \
    echo -e "${GREEN}✅ Successfully reinstalled node_modules!${NC}" || \
    echo -e "${RED}❌ Node modules ${BOLD}failed${NORMAL} to reinstall!${NC}"
}

function renode-hard() {
    echo "🗑  Removing node_modules, .next, and package-lock.json..."
    rm -rf .next/ && \
    nodeclear && \
    echo "🌤 Pulling environment" && \
    pn pm run pull-env && \
    echo "☕️ Reinstalling packages..." && \
    pn i && \
    echo "📦 Building..." && \
    storefront build && \
    echo -e "${GREEN}✅ Hard reinstall successful${NC}" || \
    echo -e "${RED}❌ Hard reinstall ${BOLD}failed${NORMAL}!${NC}"
}

# Save the current git branch for use within these aliases
alias cb='git rev-parse --abbrev-ref HEAD'
alias cbre='source ~/.branch.zshrc && echo -e "${PURPLE}🔄 Sourcing ${YELLOW}~/.branch.zshrc${NC}"'
alias cbls='cat ~/.branch.zshrc'

function featurebranch() {
    echo "Checking out develop..." && \
    git checkout develop && \
    echo -e "⬇️ ${PURPLE}Pulling develop${NC}" && \
    git pull && \
    echo -e "🆕 ${PURPLE}Creating feature branch ${LIGHT_BLUE}${BOLD}$1${NC}${NORMAL}" && \
    git checkout -b "$1" && \
    echo -e "🕊${PURPLE} Saving feature branch to ${YELLOW}${BOLD}~/.branch.zshrc${NC}${NORMAL}..." && \
    status && \
    echo -e "${GREEN}✅ 🕊 Feature branch ${LIGHT_BLUE}${BOLD}$(cb) ${GREEN}successfully created${NORMAL}${NC}" || \
    echo -e "${RED}❌ Failed to create feature branch ${LIGHT_BLUE}${BOLD}$1${NC}${NORMAL}"
}

function fb() {
    featurebranch "$1"
}

function fbdev() {
    featurebranch "$1" && \
    echo -e "${GREEN}✅ Feature branch ${LIGHT_BLUE}${BOLD}$(cb) ${GREEN}successfully created${NORMAL}${NC}" && \
    dev || \
    echo -e "${RED}❌ Failed to create feature branch ${LIGHT_BLUE}${BOLD}$1${NC}${NORMAL}"
    
}

# Switch branch and install node_modules 
function cho() {
    status && \
    git checkout $1 && \
    pull && \
    echo -e "🕊 Switched to branch ${LIGHT_BLUE}${BOLD}$(cb)${NC}${NORMAL}" && \
    pn i && \
    status && \
    echo -e "${GREEN}✅ Successfully switched to ${LIGHT_BLUE}${BOLD}$(cb)${NORMAL}${NC}" || \
    echo -e "${REG}❌ Could not switch to ${LIGHT_BLUE}${BOLD}$(cb)${NORMAL}${NC}"
}

function clone() {
    git clone $1
}

function add() {
    pn generate:types;
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

function updatebranch() {
    echo -e "${CYAN}⬇️ Pulling develop...${NC}"
    git pull origin develop && \
    echo -e "${CYAN}🛒 Checking out ${LIGHT_BLUE}${BOLD}$(cb)${NC}${NORMAL}" || \
    git checkout $(cb) && \
    echo -e "${CYAN}Merging ${LIGHT_BLUE}${BOLD}$(cb) ⬅ develop ...${NC}${NORMAL}" && \
    git merge origin && \
    echo -e "${GREEN}✅ Successfully updated ${LIGHT_BLUE}${BOLD}$(cb)${GREEN}${NORMAL} with develop${NC}" || \
    echo -e "${RED}❌ Could not merge develop into branch ${NC}"
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

alias fetch='git fetch origin $(cb)'
alias pull='git pull origin $(cb) && echo -e "${GREEN}⬇️ Pulled ${LIGHT_BLUE}$(cb)${NC}" || echo -e "${RED}❌ Could not pull ${NC}"'

function fixproblems() {
    fetch && \ 
    pull && \
    renode-hard
}

# function tst() {
#     cd /Users/duncanvankeulen/dev/TST2 && \
#     nvm use 14.17.4
# }

function tstdev() {
    tst && npm run dev
}

function fgit() {
    status && add . && git commit -m $1 && git push && git status
}

alias type-check='typecheck'

# Clearing node_modules, lockfiles, and caches.
alias nodeclear='rm -rf node_modules package-lock.json && echo -e "${GREEN}✅ Cleared node_modules and package-lock.json${NC}"'

function clearpackages() {
    nodeclear && \
    cd apps/storefront && \
    nodeclear && \
    cd ../cms && \
    nodeclear && \
    cd ../../ && \
    rm -rf pnpm-lock.yaml
    clearpncache
}

function refreshpackages() {
    pn clean:workspaces && \
    pn clean && \
    pn install
}

alias cloudtunnel='cloudflared tunnel --url http://localhost:3000'
alias cmstunnel='cloudflared tunnel --url http://localhost:3002'

# These were for trying to get local mongo to work without docker
alias mongod='brew services run mongodb-community'
alias mongod-status='brew services list'
alias mongod-stop='brew services stop mongodb-community'

# Commerce
alias commerce='cd /Users/duncanvankeulen/dev/commerce'

# Clipboard (doesn't work super well)
alias clip='pbcopy'
alias copy='pbcopy'
alias paste='pbpaste'
alias reload='source ~/.zshrc && echo -e "${PURPLE}🔄 Sourced .zshrc${NC}"'
alias rl='reload'

# Cypress and copying
alias cyp='pn cypress'
alias cyp-headless='pn cypress:run'
alias cyp-proxy='pn cal-proxy'
alias local-proxy='pn cal-proxy'
alias loc-prox='pn cal-proxy'
alias prox='npx localtunnel --port 3000 --subdomain theduncolocaldev'


alias dev='echo -e "${ORANGE}Running development server..." && pn dev'

alias addalias='f() { echo '\nalias "$1"' >> ~/.aliases.zshrc && reload };f'
alias editaliases='code ~/.aliases.zshrc'
alias ll='ls -Flags'

alias utest='pn test -- -u'

alias t3i='pn uninstall @tektoninc/t3 && pn install ~/dev/npm-lib/packages/t3/tektoninc-t3-*.tgz && storefront dev'
alias cmsdeploy='railway link && railway up'

alias prc='gh pr create -B main -d -t "$(git rev-parse --abbrev-ref HEAD): $1" -b "$(cat ./.github/pull_request_template.md)"'

alias devsync='git checkout develop && git pull && git checkout -'

alias nb='git checkout -b $1'
