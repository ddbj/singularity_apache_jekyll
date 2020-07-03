#!/bin/bash

CONTAINER_HOME=$(cd $(dirname $0); pwd)
INSTANCE="apache-build"
IMAGE="ubuntu-18.04-apache2-jekyll.simg"

singularity instance start \
-B ${CONTAINER_HOME}/httpd.conf.build:/usr/local/apache2/conf/httpd.conf \
-B ${CONTAINER_HOME}/logs-build:/usr/local/apache2/logs \
-B ${CONTAINER_HOME}/htdocs-build:/usr/local/apache2/htdocs \
-B ${CONTAINER_HOME}/cgi-bin-build:/usr/local/apache2/cgi-bin \
-B ${CONTAINER_HOME}/htpasswd.build:/usr/local/apache2/conf/.htpasswd \
-B ${CONTAINER_HOME}/www:/source \
${CONTAINER_HOME}/${IMAGE} \
$INSTANCE

singularity exec instance://${INSTANCE} /usr/local/apache2/bin/apachectl start
singularity exec instance://${INSTANCE} jekyll build -s /source -d /usr/local/apache2/htdocs --config /source/_config.yml > jekyll-build.log 2>&1 &
