# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

alias ds="doppler setup"
alias drl="nvm use; doppler run -- yarn dev"
alias drs="nvm use; doppler run -c staging -- yarn dev"
alias drd="nvm use; doppler run -c dev -- yarn dev"
alias drp="nvm use; doppler run -c prod -- yarn dev"
alias dsqs="nvm use; doppler run -- yarn sqs"

# Run containers from service directory
containers() {
    # Store current directory
    local current_dir=$(pwd)
    # Go up to backend directory
    cd ../../
    # Start SQS
    doppler run -- yarn sqs &
    # Return to service directory
    cd "$current_dir"
    # Start Redis and SQS
    doppler run -- yarn redis && doppler run -- yarn sqs
}


# Checkout main and pull
alias co-main="git checkout main; git pull origin main; nvm use; yarn"
# Reset dev to main
alias rs-dev="git fetch origin && git checkout dev && git reset --hard origin/main"
# Run tests
alias t="yarn test"
# Run tests in watch mode
alias tt="yarn test -t"
# Generate types
alias gen="nvm use; yarn gen"
# Nvm use
alias use="nvm use"


# =====================
# === MANAGE .ZSHRC ===
# =====================
# Reload .zshrc
alias rl="source ~/.zshrc && echo 'Reloaded'"
# Reload .zshrc and commit changes with a generated message
alias rlw="source ~/.zshrc && git_commit_devx_with_generated_message"
# List all custom aliases
alias la='list_custom_aliases'

# ==========================
# === GRAPHITE SHORTCUTS ===
# ==========================
# Create a new branch
alias gtc='gt_create'
# Create a new branch and submit a PR
alias gtcs='gt_create_and_submit'
alias sc='gt sync'
alias lg='gt ls'
alias st='gt status'
alias di='gt diff'
alias co='gt checkout'
alias md='gt modify'
alias mo='gt move'
alias br='gt branch'
alias ss='gt ss'
alias ams='gt add . && gt modify && gt ss'
alias am='gt add . && gt modify && gt sync'
alias scs='sc && ss'
alias trunk="gt checkout main"
alias u='gt up'
alias d='gt down'
alias ac='gt add -A && gt continue'
alias re='gt restack'

alias sd='summarise_diff'

# ============================
# === REPOSITORY SHORTCUTS ===
# ============================
alias devx="cursor ~/code/personal/devx/."
alias web="cursor ~/code/ldt/web"
alias backend="cursor ~/code/ldt/backend"
alias shared="cursor ~/code/ldt/shared"
alias remind="cursor ~/code/personal/remind-me"
alias personal="cursor ~/code/personal/personal-site"
alias dev="nvm use; yarn dev"

# Aliases for different conventional commit types
alias feat='git_commit feat'
alias fix='git_commit fix'
alias docs='git_commit docs'
alias chore='git_commit chore'
alias style='git_commit style'
alias refactor='git_commit refactor'
alias test='git_commit test'

# Create a PR
alias pr='git_pr'

# Push to main
alias pm='git_push_main'

# Add all filess
alias aa='git add .'

# ========================
# === CLAUDE SHORTCUTS ===
# ========================
# Claude "create issue" one-liner
cci() {
  # Everything you type after CCI becomes one string
  local prompt="$*"
  claude "/issues \"${prompt}\""
}

# Claude "create plan" one-liner
ccp() {
  # Everything you type after CCP becomes one string
  local prompt="$*"
  claude "/plan \"${prompt}\""
}

# Change title of current iterm
title () { printf '\e]1;%s\a' "$*"; }


function list_custom_aliases() {
    # Print the header
    echo "Listing all custom aliases in .zshrc:"
    echo "------------------------------------"
    
    # Use grep to find lines containing 'alias', then awk to extract and print the alias name and command
    grep '^alias' ~/.zshrc | awk -F'=' '{print $1 " -> " substr($0, index($0,$2))}'
}

function generate-commit-message() {
    # Your OpenAI API key stored in an environment variable
    API_KEY=$OPENAI_API_KEY

    # The diff you want to send to the API
    DIFF_CONTENT=$(git diff)

    # PAYLOAD=$(jq -n --arg diff_content "$DIFF_content" '{name: "OpenAI", type: $diff_content}')
    PAYLOAD=$(jq -n --arg message "$DIFF_CONTENT" '{
            "model": "gpt-3.5-turbo",
            "max_tokens": 50,
            "messages": [
                {
                    "role": "system",
                    "content": "You are a helpful assistant that writes short commit messages no more than 30 words long."
                },
                {
                    "role": "user",
                    "content": ("Generate a commit message for the following git diff:\n\n\n" + $message)
                }
            ]
        }')

    RESPONSE=$(curl https://api.openai.com/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d $PAYLOAD)

    # Extract the text from the response
    COMMIT_MESSAGE=$(echo $RESPONSE | jq -r  '.choices[0].message.content')
}

function summarise_diff() {
    generate-commit-message
    echo -e "\033[0;32m$COMMIT_MESSAGE\033[0m"
}

function git_commit_devx_with_generated_message() {
    local current_dir="$PWD"
    cd ~/code/personal/devx  # Change to the directory of the file

    generate-commit-message

    echo -e "\033[0;32m$COMMIT_MESSAGE\033[0m"
    echo "Do you want to use this commit message? (y/n):"
    read user_choice
    e
    case $user_choice in
        y)
            git_commit_devx "$COMMIT_MESSAGE"
            ;;
        n)
            git_commit_devx
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac

    cd "$current_dir"
}


function git_commit_devx() {
    local current_dir="$PWD"         # Store the current directory
    local message="${1:-automated commit message}"  # Use the first argument as the commit message, default to 'default commit message'
    echo "Commit message: $message"
    cd ~/code/personal/devx  # Change to the directory of the file

    git add .                         # Add all files to staging
    git commit -m "$message"          # Commit with the provided or default message
    git push                          # Push changes to remote repository

    cd "$current_dir"                # Return to the original directory
}

# Add new commit with type and message
function git_commit() {
    local branch=$(git symbolic-ref --short HEAD)
    local type=$1
    shift
    local message="$*"

    if [ -z "$message" ]; then
        echo "Commit message is required."
        return 1
    fi

    if [ -z "$(git diff --cached)" ]; then
        echo "No changes added to commit."
        return 1
    fi

    git commit -m "$type: $message"
}

# Function to push the current branch, create a pull request, and open it
function git_pr() {
    local current_branch=$(git symbolic-ref --short HEAD)
    
    # Prevent operation if on main or master branch
    if [[ "$current_branch" == "main" || "$current_branch" == "master" ]]; then
        echo "You are on $current_branch. Operation not allowed."
        return 1
    fi
    
    # Push the current branch
    git push -u origin "$current_branch"
    
    # Create a pull request
    gh pr create --fill --web
}

# Function to push the current branch, create a pull request, and open it
function git_push_main() {
    local current_branch=$(git symbolic-ref --short HEAD)
    
    # Prevent operation if on main or master branch
    if [[ "$current_branch" != "main" ]]; then
        echo "You are not on main."
        return 1
    fi
    
    # Push the current branch
    git push -u origin main
}

function gt_create() {
    local branch=$(git symbolic-ref --short HEAD)
    local type=$1
    shift
    local message="$*"

    if [ -z "$message" ]; then
        echo "Commit message is required."
        return 1
    fi

    if [ -z "$(git diff --cached)" ]; then
        echo "No changes added to commit."
        return 1
    fi

    git commit -m "$type: $message"
}

# Graphite
function gt_create() {
  local branch_name="$*"
  gt c -am "$branch_name"
}

function gt_create_and_submit() {
  local branch_name="$*"
  gt c -am "$branch_name"
  gt ss
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/mattsharp/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/mattsharp/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/mattsharp/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/mattsharp/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Add secrets
source ~/code/personal/devx/.env

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/Users/matthew.sharp/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Created by `pipx` on 2025-05-30 08:38:23
export PATH="$PATH:/Users/matthew.sharp/.local/bin"
export PATH=$PATH:$HOME/.maestro/bin

export PATH="/opt/homebrew/bin:$PATH"
