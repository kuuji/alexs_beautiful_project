#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

go get github.com/openshift/source-to-image/cmd/s2i

if [ ! -d ${HOME}/google-cloud-sdk ]; then
     export CLOUDSDK_CORE_DISABLE_PROMPTS=1
     curl https://sdk.cloud.google.com | bash ;
fi

source /home/travis/google-cloud-sdk/path.bash.inc
gcloud --quiet components update
gcloud --quiet components update kubectl
echo $GCLOUD_SERVICE_KEY | base64 --decode -i > ${HOME}/gcloud-service-key.json
gcloud auth activate-service-account --key-file ${HOME}/gcloud-service-key.json
gcloud --quiet config set project $PROJECT_NAME
gcloud --quiet config set container/cluster $CLUSTER_NAME
gcloud --quiet config set compute/zone $COMPUTE_ZONE
gcloud --quiet container clusters get-credentials $CLUSTER_NAME
