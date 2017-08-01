#!/bin/bash
BASEDIR=$(dirname $0)
#GIT_URL=$(git config --get remote.origin.url)
GIT_URL="https://github.com/imranansari/node-ci-test.git"

function build(){
  echo "npm install ...."
  cd workspace/node-ci-test/ \
  && npm install
}

function checkout(){
    echo "checkout ...."
    #mkdir ~/.ssh/ && ssh-keyscan -H github.com >> ~/.ssh/known_hosts
    mkdir workspace
    echo ${BASEDIR}/workspace
    (cd workspace &&  git clone ${GIT_URL})
}

function pipeline(){
    echo "executing pipeline ...."
    checkout \
    && build
}

function dockerBuildPipeline(){
    if [ -e Dockerfile ] 
    then
        echo "Dockerfile present, doing docker build"
        docker build -t myimage .
    fi
        echo "Dockerfile not present, building using node:onbuild"
        docker run -ti --rm --name build-app -v $PWD:/usr/src/app/ -w \
        /usr/src/app/ node bash /usr/src/app/ci.sh pipeline
}

${1:-dockerBuildPipeline}
