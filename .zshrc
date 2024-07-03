# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

alias drs="nvm use; doppler run -c staging -- yarn dev"
alias drd="nvm use; doppler run -c dev -- yarn dev"
alias drp="nvm use; doppler run -c prod -- yarn dev"
alias dsqs="nvm use; doppler run -- yarn sqs"

alias checkout-main="git checkout main; git pull origin main; nvm use; yarn"
alias reset-dev="git fetch origin && git checkout dev && git reset --hard origin/main"
alias t="yarn test"
alias tt="yarn test -t"
# Reload .zshrc
alias rl="source ~/.zshrc"
# Reload .zshrc and commit changes
alias rlw="git-commit-devx && source ~/.zshrc"

# Create a new branch
alias gtc='gt-create'
# Create a new branch and submit a PR
alias gtcs='gt-create-and-submit'
alias st='gt status'
alias di='gt diff'
alias co='gt checkout'
alias mo='gt move'
alias br='gt branch'
alias ss='gt submit'


alias devx="cursor ~/code/personal/devx/.zshrc"
alias web="cursor ~/code/ldt/web"
alias backend="cursor ~/code/ldt/backend"
alias remind="cursor ~/code/personal/remind-me"
alias personal="cursor ~/code/personal/personal-site"
alias dev="nvm use; yarn dev"

# Aliases for different conventional commit types
alias feat='git-commit feat'
alias fix='git-commit fix'
alias docs='git-commit docs'
alias chore='git-commit chore'
alias style='git-commit style'
alias refactor='git-commit refactor'
alias test='git-commit test'

# Create a PR
alias pr='git-pr'

# Push to main
alias pm='git-push-main'

# Add all filess
alias aa='git add .'

function git-commit-devx() {
    local current_dir="$PWD"         # Store the current directory
    # local message="$*"

    # if [ -z "$message" ]; then
    #     echo "Commit message is required."
    #     return 1
    # fi

    cd ~/code/personal/devx  # Change to the directory of the file

    git add .                         # Add all files to staging
    # git commit -m "$message"
    git commit -m "automated commit message"
    git push                          # Push changes to remote repository

    cd "$current_dir"                # Return to the original directory
}

# Add new commit with type and message
function git-commit() {
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
function git-pr() {
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
function git-push-main() {
    local current_branch=$(git symbolic-ref --short HEAD)
    
    # Prevent operation if on main or master branch
    if [[ "$current_branch" != "main" ]]; then
        echo "You are not on main."
        return 1
    fi
    
    # Push the current branch
    git push -u origin main
}

function gt-create() {
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
function gt-create() {
  local branch_name="$*"
  gt c -am "$branch_name"
}

function gt-create-and-submit() {
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

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
