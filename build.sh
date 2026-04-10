#!/usr/bin/env bash

if [[ ! -f ".env" ]]; then
    echo -ne "[ERR]\tCouldn't find .env file. cd to the working directory, and run:\n"
    echo -ne "[ERR]\tcp env/defaults.env .env\n"
    echo -ne "[ERR]\tEdit the file, save, and then rerun this script\n"
    exit 1
fi

. ./.env

if [[ -z "${DOCKER_REGISTRY}" ]]; then
    echo -ne "[ERR]\tDOCKER_REGISTRY unset, please add it to your .env\n"
    exit 1
fi
if [[ -z "${DOCKER_USERNAME}" ]]; then
    echo -ne "[ERR]\DOCKER_USERNAME unset, please add it to your .env\n"
    exit 1
fi
if [[ -z "${DOCKER_PROJECT}" ]]; then
    echo -ne "[ERR]\DOCKER_PROJECT unset, please add it to your .env\n"
    exit 1
fi

for DIST in $(ls dists/); do
    TAG="${DOCKER_REGISTRY}/${DOCKER_USERNAME}/${DOCKER_PROJECT}:${DIST}"
    PLATFORM="linux/amd64,linux/arm64"

    echo -ne "[INFO]\tBuilding for ${DIST} on ${PLATFORM}\n"
    docker buildx build --platform ${PLATFORM} -t ${TAG} -f dists/${DIST}/Dockerfile . || exit 1
    echo -ne "[INFO]\tSuccess! Tagged as ${TAG}\n"
done
