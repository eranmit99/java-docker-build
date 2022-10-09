#!/bin/bash -e
COMMIT_HASH=$(git rev-parse HEAD)
COMMIT_MSG=$(git show -s --format=%B $COMMIT_HASH)
echo "Runing CI workflow"
cd ..
LOCATION=$(pwd)
echo $OPS_REPO_READ_KEY | base64 -d > $LOCATION/ops_rsa
chmod 400 $LOCATION/ops_rsa
ssh-add -D
ssh-add $LOCATION/ops_rsa
git clone git@github.com:vnatures/ops.git
# second arg is migrations folder path after docker build in migrations after docker build
export PUBLISHER_SERVICE_NAME=docker-java-build-3
cd ./ops/scripts/publisher-ci-pipeline/ && ./ci.sh "$COMMIT_MSG"
echo "Done"