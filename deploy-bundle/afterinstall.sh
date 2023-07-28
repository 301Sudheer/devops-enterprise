#!/bin/bash

# Variables
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 484472757370.dkr.ecr.ap-south-1.amazonaws.com
docker pull 484472757370.dkr.ecr.ap-south-1.amazonaws.com/vprofile-qa:vprofileapp-%version%