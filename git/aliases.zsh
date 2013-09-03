# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if [[ -f $hub_path ]]
then
  alias git=$hub_path
fi

# The rest of my fun git aliases
alias g=git
alias gup='git pull --rebase'
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gd='git diff --patience'
alias gb='git branch -a'
alias gc='git commit'
alias ga='git add'
alias gaa='git add -u && git add . && gs'
alias gca='git commit -a'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gir='git rebase -i'
