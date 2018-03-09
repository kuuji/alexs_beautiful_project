#!/usr/bin/env bash
set -euov pipefail
IFS=$'\n\t'

 coveralls
if [ "$TRAVIS_BRANCH" != "master" ]; then
  s2i build . centos/python-36-centos7 us.gcr.io/alexs_beautiful_project/alexs_beautiful_project:$TRAVIS_BRANCH
  gcloud docker -- push us.gcr.io/alexs_beautiful_project/alexs_beautiful_project:$TRAVIS_BRANCH
elif [ ! -z $TRAVIS_TAG ]; then
  echo "s2i build"
  # s2i build . centos/python-36-centos7 alexs_beautiful_project:$TRAVIS_TAG
  echo "push to gcloud registry"
  # gcloud docker -- push us.gcr.io/alexs_beautiful_project/alexs_beautiful_project:$TRAVIS_TAG
  echo "deploy to k8s"
  kubectl config view
  kubectl config current-context
  kubectl set image deployment/alexs_beautiful_project alexs_beautiful_project=us.gcr.io/alexs_beautiful_project/alexs_beautiful_project:$TRAVIS_TAG
fi
