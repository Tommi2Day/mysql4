#!/bin/bash
#
# mysql4 docker container starter


#define variables
if [ -r run.vars ]; then
	source run.vars
fi

#set defaults if needed
DOCKER_SHARED=${DOCKER_SHARED:-$(pwd)}
SHARED_DIR=${DOCKER_SHARED}/mysql4-shared
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-mysql4}
EXT_DB_PORT=${EXT_DB_PORT:-32306}

#debug
if [ -z "$DEBUG" ]; then
	RUN="-d "
else
	RUN="--rm=true -it --entrypoint bash "

fi

#docker volumes on windows need this extra slash
if [ "$OSTYPE" = "msys" ]; then
	P=/
fi


#stop existing container
docker stop mysql4 >/dev/null 
docker rm mysql4 >/dev/null

if [ "$DEBUG" = "clean" ]; then
	#clean all if debug set to clean
	rm -Rf ${SHARED_DIR}
fi

#create shared directories
if [ ! -d  ${SHARED_DIR} ]; then
		mkdir -p ${SHARED_DIR}
fi



#run it
#--add-host="mysql4:127.0.0.1" \
docker run --name mysql4 \
-e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
-v $P${SHARED_DIR}:/db \
-p ${EXT_DB_PORT}:3306 \
$RUN \
tommi2day/mysql4

