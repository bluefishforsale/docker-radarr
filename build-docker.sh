#!/bin/bash

BUILD=latest
SERVICE=radarr
USER=bluefishforsale

docker build --pull --tag ${USER}/${SERVICE}:${BUILD} .
