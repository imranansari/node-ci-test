#!/bin/bash
BASEDIR=$(dirname $0)

function build(){
  echo "npm install ...."
  cd workspace/test-node-module/ \
  && npm install
}

function checkout(){
    echo "checkout ...."
    mkdir workspace
    echo ${BASEDIR}/workspace
    (cd workspace &&  git clone git://github.com/imranansari/test-node-module.git)
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
        //docker build -t myimage .
    fi
        echo "Dockerfile not present, building using node:onbuild"
        docker run -ti --rm --name build-app -v $PWD:/usr/src/app/ -w \
        /usr/src/app/ node bash /usr/src/app/ci.sh pipeline
}

${1:-dockerBuildPipeline}
