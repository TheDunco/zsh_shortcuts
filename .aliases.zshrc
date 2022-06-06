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

alias status='echo -e "\t📈\t📊\t📊\t📊\t📉" && git status'
alias log='git log'
alias diff='git diff'
alias branch='git branch'
alias br='git branch'
alias merge='git merge'
alias rebase='git rebase'

alias type-check='echo -e "${ORANGE}⌨️ ✔️ Running type-check..." && \
    npm run type-check && \
    echo -e "${GREEN}✅ Type-check ran successfully!${NC}" || \
    echo -e "${RED}❌ Type-check failed!${NC}"'
alias push='git push --set-upstream origin $FEATURE_BRANCH && status'

alias test='echo -e "${ORANGE}🧪 Running jest tests" && \
    npm run test && \
    echo -e "${GREEN}✅ Tests ran successfully!${NC}" || \
    echo -e "${RED}❌ Tests failed!${NC}"'

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
    type-check && \
    git commit -m "$1" && \
    status && \
    echo -e "${GREEN}✅ Commit successful! Message: ${LIGHT_CYAN}${BOLD}$1${NORMAL}${NC}" || \
    echo -e "${RED}❌ Commit failed!${NC}"
}

# Fast commit: commit and push changes
function fcommit() {
    test && \
    type-check && \
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

function tests() {
    test && \
    type-check
}

function alltest() {
    test
    type-check
    cyp-headless
}

# Reinstall node_modules and discard changes to package-lock.json
function renode() {
    echo "🗑  Removing node_modules and package-lock.json..."
    rm -rf package-lock.json node_modules/ && \
    echo "☕️ Reinstalling packages..." && \
    npm i && \
    restore package-lock.json && \
    echo -e "${GREEN}✅ Successfully reinstalled node_modules!${NC}" || \
    echo -e "${RED}❌ Node modules ${BOLD}failed${NORMAL} to reinstall!${NC}"
}

# Save the current git branch for use within these aliases
alias cb='br | grep "*" | tr -d "* "'
alias cbre='source ~/.branch.zshrc && echo -e "${PURPLE}🔄 Sourcing ${YELLOW}~/.branch.zshrc${NC}" && br'
alias cbls='cat ~/.branch.zshrc'

# Auto save current branch to ~/.branch.zshrc
function cbsave() {
    echo -n "export FEATURE_BRANCH=" > ~/.branch.zshrc && \
    cb >> ~/.branch.zshrc && \
    cbre && \
    echo -e "${GREEN}✅ Successfully saved current branch ${LIGHT_BLUE}$FEATURE_BRANCH ${NC}to ${YELLOW}${BOLD}~/.branch.zshrc!${NC}${NORMAL}" || \
    echo -e "${RED}❌ Failed to save current branch to ${YELLOW}${BOLD}~/.branch.zshrc!${NC}${NORMAL}"
}

function featurebranch() {
    echo "Checking out develop..." && \
    git checkout develop && \
    echo -e "⬇️ ${PURPLE}Pulling develop${NC}" && \
    git pull && \
    echo -e "🆕 ${PURPLE}Creating feature branch ${LIGHT_BLUE}${BOLD}$1${NC}${NORMAL}" && \
    git checkout -b "$1" && \
    echo -e "🕊${PURPLE} Saving feature branch to ${YELLOW}${BOLD}~/.branch.zshrc${NC}${NORMAL}..." && \
    cbsave && \
    status && \
    echo -e "${GREEN}✅ 🕊 Feature branch ${LIGHT_BLUE}${BOLD}$FEATURE_BRANCH ${GREEN}successfully created${NORMAL}${NC}" || \
    echo -e "${RED}❌ Failed to create feature branch ${LIGHT_BLUE}${BOLD}$1${NC}${NORMAL}"
}

function fb() {
    featurebranch "$1"
}

function cho() {
    status && \
    git checkout $1 && \
    cbsave && \
    echo -e "🕊 Switched to branch ${LIGHT_BLUE}${BOLD}$FEATURE_BRANCH${NC}${NORMAL}" && \
    renode && \
    git restore package-lock.json && \
    status && \
    echo -e "${GREEN}✅ Successfully switched to ${LIGHT_BLUE}${BOLD}$FEATURE_BRANCH${NORMAL}${NC}" || \
    echo -e "${REG}❌ Could not switch to ${LIGHT_BLUE}${BOLD}$FEATURE_BRANCH${NORMAL}${NC}"
}

function chodev() {
    cho $1 && \
    develop && \
    echo -e "${GREEN}✅ Switched to branch. Running develop ${NC}" || \
    echo -e "${RED}❌ Could not run develop ${NC}"
}

function clone() {
    git clone $1
    status
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

alias fetch='git fetch origin $FEATURE_BRANCH'
alias pull='git pull origin $FEATURE_BRANCH'

# Other non-git commands
alias commerce='cd /Users/duncanvankeulen/dev/commerce'
alias clip='pbcopy'
alias cp='pbcopy'
alias paste='pbpaste'
alias reload='source ~/.zshrc && echo -e "${PURPLE}🔄 Sourced .zshrc${NC}"'
alias rl='reload'

alias cyp='npm run cypress'
alias cyp-headless='npm run cypress:run'
alias cyp-proxy='npm run local-proxy'


alias dev='commerce && echo -e "${ORANGE}Running development server..." && npm run dev'

alias addalias='f() { echo "alias" $1 >> ~/.aliases.zshrc && reload };f'
alias editaliases='code ~/.aliases.zshrc'

alias prox='npx localtunnel --port 3000 --subdomain theduncolocaldev'
alias stat='status'
alias ll='ls -Flags'

alias utest='npm test -- -u'
