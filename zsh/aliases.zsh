alias reload!='. ~/.zshrc'
alias k='kubectl'
alias kctx="kubectx"
alias kns="kubens"
alias gcl='gcloud'
alias ft='find . -type f -name "application-default.yaml" -exec yq e ".kafka.topics" {} \; | grep name: | tr -s " " | cut -d " " -f 3 | sort -u | nl'
alias dev='gcloud beta container clusters get-credentials rental-dev-v1 --region us-east4 --project rental-dev'
alias devctl='gcloud beta container clusters get-credentials rental-dev-ctl-v1 --region us-east4-c --project rental-dev'
alias stage='gcloud beta container clusters get-credentials rental-staging-v1 --region us-east4 --project rental-staging'
alias stagectl='gcloud beta container clusters get-credentials rental-staging-ctl-v1 --region us-east4-c --project rental-staging'
alias prod='gcloud beta container clusters get-credentials rental-prod-v1 --region us-east4 --project rental-prod'
alias prodctl='gcloud beta container clusters get-credentials rental-prod-ctl-v1 --region us-east4-c --project rental-prod'
alias dcc="docker ps -a | grep 'Exit' | awk '{print 1}' | xargs -L 1 docker rm"
alias dci="docker images -a | grep none | awk '{print 3}' | xargs -L 1 docker rmi"
alias dcl="dockercleancontainers && dockercleanimages"
alias kdry='kustomize build | kubectl apply --dry-run=server --validate -f -'
alias kdiff='kustomize build | kubectl diff -f -'
alias rental-ds='gcloud beta container clusters get-credentials us-east1-nuuly-4c1e44f4-gke --region us-east1-b --project rental-ds'
alias deployer='k -n ctl exec deployment/deployer -it -- /bin/bash'
alias scale-out='k -n ctl delete job scale-out-manual && k -n ctl create job --from=cronjob/scale-out scale-out-manual && sleep 15 && k -n ctl logs job/scale-out-manual -f'
alias scale-in='k -n ctl delete job scale-in-manual && k -n ctl create job --from=cronjob/scale-in scale-in-manual && sleep 15 && k -n ctl logs job/scale-in-manual -f'
# Prod support
alias topic_export='bash $DEV_SCRIPTS/topic_export.sh'
alias topic_export_json='bash $DEV_SCRIPTS/topic_export_json.sh'
alias get_kafkacat='kubectl -n confluent get pods --selector=app=kafkacat -o name'
alias kafka-produce='kubectl -n confluent exec -it deployment/kafkacat -- kafkacat -H "X-URBN-LOCATION-ID=DC-1" -H "X-URBN-ASSOCIATE-ID=MANUAL_ADJUSTMENT" -X partitioner=murmur2_random -K: -P -t'
alias kafka-pipe-produce='kubectl -n confluent exec -it deployment/kafkacat -- kafkacat -H "X-URBN-LOCATION-ID=DC-1" -H "X-URBN-ASSOCIATE-ID=MANUAL_ADJUSTMENT" -X partitioner=murmur2_random -K\| -P -t'
alias table-flip='echo "（╯°□°）╯︵ ┻━┻" | pbcopy'
alias kick-batching='k -n rms delete job dsa-batching-manual && k -n rms create job --from=cronjob/dsa-batching-cronjob dsa-batching-manual && sleep 15 && k -n rms logs job/dsa-batching-manual -f'
alias ke='k exec -ti'
alias kgp='k get pods'
alias kd='k describe'
alias kw='kubectl get pods -w -n'
alias kgd='k get deployment'
alias gbdry='git branch --merged | egrep -v "(^\*|master|main|dev|upstream)"'
alias gbdel='git branch --merged | egrep -v "(^\*|master|main|dev|upstream)" | xargs git branch -d'
alias repos='cd ~/repos'
alias ksql-stage-resale='docker run --rm -it confluentinc/ksqldb-cli:0.22.0 ksql -u FHTCJ5MY7YUG4RL2 -p Bz9LZG3+tqtpQfsZusSI9PkFYXD1GK19Z1u3m7lCw1V8FiZxlFeORPgEkTl5bGsB "https://pksqlc-r5o8p.us-east4.gcp.confluent.cloud:443"'
alias ksql-dev-resale='docker run --rm -it confluentinc/ksqldb-cli:0.22.0 ksql -u 2RMTG2EE4JLOVZND -p jUPFMBk/W1RqLazNbvZLSPSTWXMa/UNFlr1scvfvZdxRY96m4A7PKaXJbd3zUWFZ "https://pksqlc-vrd8j.us-east4.gcp.confluent.cloud:443"'
alias ksql-prod-resale='docker run --rm -it confluentinc/ksqldb-cli:0.22.0 ksql -u ZSCRXWPLKLEH56HR -p a/tHlJz/6D6RPVVNE3lG9H2rcuYc7oVocVryu5qzzb2ihyL8VCxOBUCVWVzm4UTv "https://pksqlc-gng2m.us-east4.gcp.confluent.cloud:443"'
alias ksql-dev-rental='docker run --rm -it confluentinc/ksqldb-cli:0.22.0 ksql -u M74ZC4KFX33MMRVC -p CAXxTlDe5UEqpPa5ZbbxWyYepD6uw8O4x98fr/Ya75XChKxuTWxLnOYH9gA04Jcp "https://pksqlc-6orx2.us-east4.gcp.confluent.cloud:443"'
alias cat=bat
