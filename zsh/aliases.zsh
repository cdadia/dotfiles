alias reload!='. ~/.zshrc'
alias k='kubectl'
alias gcl='gcloud'
alias fat='find . -type f -name "application-default.yaml" -exec yq r {} "kafka.topics" \; | grep name: | tr -s " " | cut -d " " -f 3 | sort -u | nl'
#alias dockercleancontainers="docker ps -a -notrunc| grep 'Exit' | awk '{print \$1}' | xargs -L 1 -r docker rm"
#alias dockercleanimages="docker images -a -notrunc | grep none | awk '{print \$3}' | xargs -L 1 -r docker rmi"
#alias dockerclean="dockercleancontainers && dockercleanimages"
