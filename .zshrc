export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

alias mm="git fetch; git merge origin/main"
alias drs="doppler run -c staging -- yarn dev"
alias drd="doppler run -c dev -- yarn dev"
alias drp="doppler run -c prod -- yarn dev"
alias checkout-main="git checkout main; git pull origin main; nvm use; yarn"
alias t="yarn test"
alias tt="yarn test -t"
