#!/bin/bash
BASEDIR=$(dirname $0)
GIT_URL=$(git config --get remote.origin.url)
REPO_NAME=${GIT_URL}|sed -n 's#.*/\([^.]*\)\.git#\1#p'

function build(){
  echo "npm install ...."
  echo dirname
  cd workspace/${REPO_NAME}/ \
  && npm install && npm run lint && npm run test
}

function checkout(){
    echo "checkout ...."
    rm -rf workspace
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
