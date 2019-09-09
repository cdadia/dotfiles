alias reload!='. ~/.zshrc'
alias k='kubectl'
alias gcl='gcloud'
alias fat='find . -type f -name "application-default.yaml" -exec yq r {} "kafka.topics" \; | grep name: | tr -s " " | cut -d " " -f 3 | sort -u | nl'
alias dev='gcloud beta container clusters get-credentials rental-dev-v1 --region us-east4 --project rental-dev'
alias stage='gcloud beta container clusters get-credentials rental-staging-v1 --region us-east4 --project rental-staging'
alias prod='gcloud beta container clusters get-credentials rental-prod-v1 --region us-east4 --project rental-prod'
alias dcc="docker ps -a | grep 'Exit' | awk '{print 1}' | xargs -L 1 docker rm"
alias dci="docker images -a | grep none | awk '{print 3}' | xargs -L 1 docker rmi"
alias dcl="dockercleancontainers && dockercleanimages"
function gpf(){
  kubectl -n $1 port-forward $2 $3
}
