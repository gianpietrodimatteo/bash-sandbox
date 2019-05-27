#!/bin/bash

clean_package='false'
backend='false'
frontend='false'
SKIP_TESTS='-DskipTests'
MVN_PROFILE_FRONTEND='-P build-node'

print_usage() {
  printf "Usage: ..."
}

while getopts 'cbf' flag; do
  case "${flag}" in
    c) clean_package='true' ;;
    b) backend='true' ;;
    f) frontend='true' ;;
    *) print_usage
       exit 1 ;;
  esac
done

# One flag only
if $clean_package && ! $backend && ! $frontend; then
    echo Project Clean Package
    mvn clean package $SKIP_TESTS
fi
if ! $clean_package && $backend && ! $frontend; then
    echo Deploy Backend
    mvn wildfly:deploy $SKIP_TESTS -f roadcard-caminhoneiro-backend/
fi
if ! $clean_package && ! $backend && $frontend; then
    echo Deploy Frontend
    mvn wildfly:deploy $SKIP_TESTS -f roadcard-caminhoneiro-frontend/ "$MVN_PROFILE_FRONTEND"
fi

# Two flags
if $clean_package && $backend && ! $frontend; then
    echo Package And Deploy Backend
    mvn clean package $SKIP_TESTS -f roadcard-caminhoneiro-backend/ && \
    mvn wildfly:deploy $SKIP_TESTS -f roadcard-caminhoneiro-backend/
fi
if $clean_package && ! $backend && $frontend; then
    echo Package And Deploy Frontend
    mvn clean package $SKIP_TESTS -f roadcard-caminhoneiro-frontend/ "$MVN_PROFILE_FRONTEND" && \
    mvn wildfly:deploy $SKIP_TESTS -f roadcard-caminhoneiro-frontend/ "$MVN_PROFILE_FRONTEND"
fi
if ! $clean_package && $backend && $frontend; then
    echo Deploy Backend And Frontend
    mvn wildfly:deploy $SKIP_TESTS -f roadcard-caminhoneiro-backend/ && \
    mvn wildfly:deploy $SKIP_TESTS -f roadcard-caminhoneiro-frontend/ "$MVN_PROFILE_FRONTEND"
fi

# All flags
if  $clean_package && $backend && $frontend; then
    echo Package And Deploy All Projects Including Root
    mvn clean package $SKIP_TESTS && \
    mvn clean package $SKIP_TESTS -f roadcard-caminhoneiro-backend/ && \
    mvn wildfly:deploy $SKIP_TESTS -f roadcard-caminhoneiro-backend/ && \
    mvn clean package $SKIP_TESTS -f roadcard-caminhoneiro-frontend/ "$MVN_PROFILE_FRONTEND" && \
    mvn wildfly:deploy $SKIP_TESTS -f roadcard-caminhoneiro-frontend/ "$MVN_PROFILE_FRONTEND"
fi
