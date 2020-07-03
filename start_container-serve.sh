#!/bin/bash

CONTAINER_HOME=$(cd $(dirname $0); pwd)
INSTANCE="apache-serve"
IMAGE="ubuntu-18.04-apache2-jekyll.simg"
SOURCE_DIR="source"

singularity instance start \
-B ${CONTAINER_HOME}/httpd.conf.serve:/usr/local/apache2/conf/httpd.conf \
-B ${CONTAINER_HOME}/logs-serve:/usr/local/apache2/logs \
-B ${CONTAINER_HOME}/htdocs-serve:/usr/local/apache2/htdocs \
-B ${CONTAINER_HOME}/cgi-bin-serve:/usr/local/apache2/cgi-bin \
-B ${CONTAINER_HOME}/htpasswd.serve:/usr/local/apache2/conf/.htpasswd \
-B ${CONTAINER_HOME}/${SOURCE_DIR}:/source \
${CONTAINER_HOME}/${IMAGE} \
${INSTANCE}

singularity exec instance://${INSTANCE} /usr/local/apache2/bin/apachectl start
singularity exec instance://${INSTANCE} jekyll serve -s /source -d /usr/local/apache2/htdocs --config /source/_config.yml > jekyll-serve.log  2>&1 &
