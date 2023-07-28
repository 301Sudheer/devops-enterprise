#!/bin/bash

if [ "$(docker inspect -f '{{.State.Running}}' vprofile_app)" == "true" ]; then
    docker stop vprofile_app
fi
