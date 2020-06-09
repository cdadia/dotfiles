autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh
if [ -n "`which git` 2> /dev/null" ]; then
  GIT="git"
else
  GIT="/usr/bin/git"
fi

git_branch() {
  echo $($GIT symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  st=$($GIT status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ $st == "nothing to commit (working directory clean)" ]]
    then
      echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($GIT symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  $GIT cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

directory_name(){
  echo "%{$fg_bold[cyan]%}%2~%\/%{$reset_color%}"
}

kubectl_prompt(){
  if echo $ZSH_KUBECTL_PROMPT | grep -q "dev"
  then
    echo "%{$fg[blue]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}"
  elif echo $ZSH_KUBECTL_PROMPT | grep -q "staging"
  then
    echo "%{$fg[green]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}"
  elif echo $ZSH_KUBECTL_PROMPT | grep -q "prod"
  then
    echo "%{$fg[red]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}"
  else
    echo ""
  fi
}

export PROMPT=$'\n in $(directory_name) $(git_dirty)$(need_push) $(kubectl_prompt)\n› '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
