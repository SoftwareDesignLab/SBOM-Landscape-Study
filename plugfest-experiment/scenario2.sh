#!/bin/bash

# File: scenario2.sh
# Description: Build Docker Images and generate SBOMs for each test case
#
# @author: Derek Garcia

# Project Paths
s2c1="../../scenario2/case1b/code"
s2c2="../../scenario2/case2b/code"
s2c3="../../scenario2/case3b/code"

abs_s2c1="$(pwd)/scenario2/case1b/out"
abs_s2c2="$(pwd)/scenario2/case2b/out"
abs_s2c3="$(pwd)/scenario2/case3b/out"



# Ensure Docker is running
docker ps > /dev/null 2>&1 && echo "Docker is running" || echo "Docker Daemon is not running! Please ensure docker is running"

# Build plugfest image
echo "Building Plugfest Test Environment"
docker build -t plugfest:no-mvn -f docker/without_maven/plugfest.Dockerfile .

# Build tool images
echo "Building Tool Images: This may take a while"
echo "Building Scenario 2; Case 1"
docker build --build-arg project_path=$s2c1 -t cdxgen:s2c1 -f docker/without_maven/cdxgen.Dockerfile .
docker build --build-arg project_path=$s2c1 -t ort:s2c1 -f docker/without_maven/ort.Dockerfile .
docker build --build-arg project_path=$s2c1 -t spdxgen:s2c1 -f docker/without_maven/spdxgen.Dockerfile .
docker build --build-arg project_path=$s2c1 -t syft:s2c1 -f docker/without_maven/syft.Dockerfile .
docker build --build-arg project_path=$s2c1 -t trivy:s2c1 -f docker/without_maven/trivy.Dockerfile .

echo "Building Scenario 2; Case 2"
docker build --build-arg project_path=$s2c2 -t cdxgen:s2c2 -f docker/without_maven/cdxgen.Dockerfile .
docker build --build-arg project_path=$s2c2 -t ort:s2c2 -f docker/without_maven/ort.Dockerfile .
docker build --build-arg project_path=$s2c2 -t spdxgen:s2c2 -f docker/without_maven/spdxgen.Dockerfile .
docker build --build-arg project_path=$s2c2 -t syft:s2c2 -f docker/without_maven/syft.Dockerfile .
docker build --build-arg project_path=$s2c2 -t trivy:s2c2 -f docker/without_maven/trivy.Dockerfile .

echo "Building Scenario 2; Case 3"
docker build --build-arg project_path=$s2c3 -t cdxgen:s2c3 -f docker/without_maven/cdxgen.Dockerfile .
docker build --build-arg project_path=$s2c3 -t ort:s2c3 -f docker/without_maven/ort.Dockerfile .
docker build --build-arg project_path=$s2c3 -t spdxgen:s2c3 -f docker/without_maven/spdxgen.Dockerfile .
docker build --build-arg project_path=$s2c3 -t syft:s2c3 -f docker/without_maven/syft.Dockerfile .
docker build --build-arg project_path=$s2c3 -t trivy:s2c3 -f docker/without_maven/trivy.Dockerfile .

echo "Build Complete; Starting generation"
mkdir $abs_s2c1
mkdir $abs_s2c2
mkdir $abs_s2c3
echo "Running Scenario 2; Case 1"
docker run --rm --mount type=bind,source=$abs_s2c1,target=/out -it cdxgen:s2c1
docker run --rm --mount type=bind,source=$abs_s2c1,target=/out -it ort:s2c1
docker run --rm --mount type=bind,source=$abs_s2c1,target=/out -it spdxgen:s2c1
docker run --rm --mount type=bind,source=$abs_s2c1,target=/out -it syft:s2c1
docker run --rm --mount type=bind,source=$abs_s2c1,target=/out -it trivy:s2c1

echo "Running Scenario 2; Case 2"
docker run --rm --mount type=bind,source=$abs_s2c2,target=/out -it cdxgen:s2c2
docker run --rm --mount type=bind,source=$abs_s2c2,target=/out -it ort:s2c2
docker run --rm --mount type=bind,source=$abs_s2c2,target=/out -it spdxgen:s2c2
docker run --rm --mount type=bind,source=$abs_s2c2,target=/out -it syft:s2c2
docker run --rm --mount type=bind,source=$abs_s2c2,target=/out -it trivy:s2c2

echo "Running Scenario 2; Case 3"
docker run --rm --mount type=bind,source=$abs_s2c3,target=/out -it cdxgen:s2c3
docker run --rm --mount type=bind,source=$abs_s2c3,target=/out -it ort:s2c3
docker run --rm --mount type=bind,source=$abs_s2c3,target=/out -it spdxgen:s2c3
docker run --rm --mount type=bind,source=$abs_s2c3,target=/out -it syft:s2c3
docker run --rm --mount type=bind,source=$abs_s2c3,target=/out -it trivy:s2c3


read -p "Run complete. Press any key to finish. . ."
