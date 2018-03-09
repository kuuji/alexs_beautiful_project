#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# coveralls
echo $TRAVIS_BRANCH
echo $TRAVIS_TAG
if [ "$TRAVIS_BRANCH" != "master" ]; then
  s2i build . centos/python-36-centos7 alexs_beautiful_project:$TRAVIS_BRANCH
elif [ ! -z $TRAVIS_TAG ]; then
  s2i build . centos/python-36-centos7 alexs_beautiful_project:$TRAVIS_TAG
fi
