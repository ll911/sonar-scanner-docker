#!/bin/sh
set -e

if [[ "$1" == "sonar-scanner" ]]; then
  git clone $gitRepo /tmp/src

  if [[ "$2" == "run" || "$2" == "scan" ]]; then
    export JAVA_HOME=$SS_HOME/jre
    export PATH=$SS_HOME/bin:$SS_HOME/jre/bin:$PATH 
    export LD_LIBRARY_PATH=$SS_HOME/lib:$SS_HOME/jre/lib:$LD_LIBRARY_PATH
    
    sonar-scanner -Dsonar.login=$sonarToken -Dsonar.host.url=$sonarqubeSvc \
    -Dsonar.projectKey=$repoName -Dsonar.projectVersion=$gitTag -Dsonar.sources=/tmp/src 
  fi
fi
exec "$@"
