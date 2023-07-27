#!/bin/bash

docker run -d -p --name vprofile_app 8080:8080 484472757370.dkr.ecr.ap-south-1.amazonaws.com/vprofile-qa:vprofileapp-%version%