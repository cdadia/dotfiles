autoload colors && colors

if [ -n "`which git` 2> /dev/null" ]; then
  GIT="git"
else
  GIT="/usr/bin/git"
fi

# Echoes information about Git repository status when inside a Git repository
git_info() {

  # Exit if not inside a Git repository
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  # Git branch/tag, or name-rev if on detached head
  local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

  local AHEAD="%{$fg[red]%}⇡NUM%{$reset_color%}"
  local BEHIND="%{$fg[cyan]%}⇣NUM%{$reset_color%}"
  local MERGING="%{$fg[magenta]%}⚡︎%{$reset_color%}"
  local UNTRACKED="%{$fg[red]%}●%{$reset_color%}"
  local MODIFIED="%{$fg[yellow]%}●%{$reset_color%}"
  local STAGED="%{$fg[green]%}●%{$reset_color%}"

  local -a DIVERGENCES
  local -a FLAGS

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    DIVERGENCES+=( "${AHEAD//NUM/$NUM_AHEAD}" )
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    DIVERGENCES+=( "${BEHIND//NUM/$NUM_BEHIND}" )
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    FLAGS+=( "$MERGING" )
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    FLAGS+=( "$UNTRACKED" )
  fi

  if ! git diff --quiet 2> /dev/null; then
    FLAGS+=( "$MODIFIED" )
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    FLAGS+=( "$STAGED" )
  fi

  local -a GIT_INFO
  GIT_INFO+=( "\033[38;5;15m±" )
  [ -n "$GIT_STATUS" ] && GIT_INFO+=( "$GIT_STATUS" )
  [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)DIVERGENCES}" )
  [[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)FLAGS}" )
  GIT_INFO+=( "\033[38;5;15m$GIT_LOCATION%{$reset_color%}" )
  echo "${(j: :)GIT_INFO}"

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

GCLOUD_BIN="${GCLOUD_BIN:-gcloud}"
GCLOUD_PS1_ENABLE="${GCLOUD_PS1_ENABLE:-true}"
GCLOUD_PS1_SYMBOL_ENABLE="${GCLOUD_PS1_SYMBOL_ENABLE:-true}"
GCLOUD_PS1_SYMBOL="${GCLOUD_PS1_SYMBOL:-☁ }"

if [ "${ZSH_VERSION-}" ]; then
  GCLOUD_PS1_SHELL="zsh"
elif [ "${BASH_VERSION-}" ]; then
  GCLOUD_PS1_SHELL="bash"
fi

gcloudon() {
  GCLOUD_PS1_ENABLE=true
}

gcloudoff() {
  GCLOUD_PS1_ENABLE=false
}

gcloud_ps1() {
  # Terminal colors
  local reset='\033[0m'
  local blue='\033[0;34m'
  local cyan='\033[0;36m'

  GCLOUD_PS1=""
  if [[ ${GCLOUD_PS1_ENABLE} == true ]]; then
    GCLOUD_PS1+='('
    if [[ ${GCLOUD_PS1_SYMBOL_ENABLE} == true ]]; then
      GCLOUD_PS1+="${blue}${GCLOUD_PS1_SYMBOL} "
    fi
    ACTIVE_CONF=$(${GCLOUD_BIN} config configurations list --format='value(name)' --filter='IS_ACTIVE=true' 2> /dev/null)
    GCLOUD_PS1+="${cyan}$ACTIVE_CONF${reset})"
  fi

  echo "${GCLOUD_PS1}"
}

CCLOUD_PS1_ENABLE="${CCLOUD_PS1_ENABLE:-false}"

ccloudon() {
  CCLOUD_PS1_ENABLE=true
}

ccloudoff() {
  CCLOUD_PS1_ENABLE=false
}


ccloud_ps1() {

  CCLOUD_PS1=""
  # Configure ccloud prompt if configured
  if [ -n "`which ccloud` 2> /dev/null" ]; then
    if [[ ${CCLOUD_PS1_ENABLE} == true ]]; then
      CCLOUD_PS1+=$(ccloud prompt 2> /dev/null)
    fi
  fi

  echo "$CCLOUD_PS1"
}

export PROMPT=$'\n in $(directory_name) $(git_info) $(gcloud_ps1) $(kubectl_prompt) $(ccloud_ps1)\n› '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
