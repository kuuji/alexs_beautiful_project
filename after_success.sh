#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

 coveralls
if [ "$TRAVIS_BRANCH" != "master" ]; then
  s2i build . centos/python-36-centos7 us.gcr.io/alexs_beautiful_project/alexs_beautiful_project:$TRAVIS_BRANCH
  gcloud docker -- push us.gcr.io/alexs_beautiful_project/alexs_beautiful_project:$TRAVIS_BRANCH
fi

if [ ! -z $TRAVIS_TAG ]; then
  echo "deploy to k8s"
  ${HOME}/google-cloud-sdk/bin/kubectl config view
  ${HOME}/google-cloud-sdk/bin/kubectl config current-context
  ${HOME}/google-cloud-sdk/bin/kubectl set image deployment/alexs_beautiful_project alexs_beautiful_project=us.gcr.io/alexs_beautiful_project/alexs_beautiful_project:$TRAVIS_TAG
fi
