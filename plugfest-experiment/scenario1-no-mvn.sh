#!/bin/bash

# File: scenario1-no-mvn.sh
# Description: Build Docker Images and generate SBOMs for each test case
#
# @author: Derek Garcia

# Project Paths
s1c1="../../scenario1/case1a/code"
s1c2="../../scenario1/case2a/code"
s1c3="../../scenario1/case3a/code"

abs_s1c1="$(pwd)/scenario1/case1a/out-no-mvn"
abs_s1c2="$(pwd)/scenario1/case2a/out-no-mvn"
abs_s1c3="$(pwd)/scenario1/case3a/out-no-mvn"



# Ensure Docker is running
docker ps > /dev/null 2>&1 && echo "Docker is running" || echo "Docker Daemon is not running! Please ensure docker is running"

# Build plugfest image
echo "Building Plugfest Test Environment"
docker build -t plugfest:no-mvn -f docker/without_maven/plugfest.Dockerfile .

# Build tool images
echo "Building Tool Images: This may take a while"
echo "Building Scenario 1; Case 1"
docker build --build-arg project_path=$s1c1 -t cdxgen:s1c1 -f docker/without_maven/cdxgen.Dockerfile .
docker build --build-arg project_path=$s1c1 -t ort:s1c1 -f docker/without_maven/ort.Dockerfile .
docker build --build-arg project_path=$s1c1 -t spdxgen:s1c1 -f docker/without_maven/spdxgen.Dockerfile .
docker build --build-arg project_path=$s1c1 -t syft:s1c1 -f docker/without_maven/syft.Dockerfile .
docker build --build-arg project_path=$s1c1 -t trivy:s1c1 -f docker/without_maven/trivy.Dockerfile .

echo "Building Scenario 1; Case 2"
docker build --build-arg project_path=$s1c2 -t cdxgen:s1c2 -f docker/without_maven/cdxgen.Dockerfile .
docker build --build-arg project_path=$s1c2 -t ort:s1c2 -f docker/without_maven/ort.Dockerfile .
docker build --build-arg project_path=$s1c2 -t spdxgen:s1c2 -f docker/without_maven/spdxgen.Dockerfile .
docker build --build-arg project_path=$s1c2 -t syft:s1c2 -f docker/without_maven/syft.Dockerfile .
docker build --build-arg project_path=$s1c2 -t trivy:s1c2 -f docker/without_maven/trivy.Dockerfile .

echo "Building Scenario 1; Case 3"
docker build --build-arg project_path=$s1c3 -t cdxgen:s1c3 -f docker/without_maven/cdxgen.Dockerfile .
docker build --build-arg project_path=$s1c3 -t ort:s1c3 -f docker/without_maven/ort.Dockerfile .
docker build --build-arg project_path=$s1c3 -t spdxgen:s1c3 -f docker/without_maven/spdxgen.Dockerfile .
docker build --build-arg project_path=$s1c3 -t syft:s1c3 -f docker/without_maven/syft.Dockerfile .
docker build --build-arg project_path=$s1c3 -t trivy:s1c3 -f docker/without_maven/trivy.Dockerfile .

echo "Build Complete; Starting generation"
mkdir $abs_s1c1
mkdir $abs_s1c2
mkdir $abs_s1c3
echo "Running Scenario 1; Case 1"
docker run --rm --mount type=bind,source=$abs_s1c1,target=/out -it cdxgen:s1c1
docker run --rm --mount type=bind,source=$abs_s1c1,target=/out -it ort:s1c1
docker run --rm --mount type=bind,source=$abs_s1c1,target=/out -it spdxgen:s1c1
docker run --rm --mount type=bind,source=$abs_s1c1,target=/out -it syft:s1c1
docker run --rm --mount type=bind,source=$abs_s1c1,target=/out -it trivy:s1c1

echo "Running Scenario 1; Case 2"
docker run --rm --mount type=bind,source=$abs_s1c2,target=/out -it cdxgen:s1c2
docker run --rm --mount type=bind,source=$abs_s1c2,target=/out -it ort:s1c2
docker run --rm --mount type=bind,source=$abs_s1c2,target=/out -it spdxgen:s1c2
docker run --rm --mount type=bind,source=$abs_s1c2,target=/out -it syft:s1c2
docker run --rm --mount type=bind,source=$abs_s1c2,target=/out -it trivy:s1c2

echo "Running Scenario 1; Case 3"
docker run --rm --mount type=bind,source=$abs_s1c3,target=/out -it cdxgen:s1c3
docker run --rm --mount type=bind,source=$abs_s1c3,target=/out -it ort:s1c3
docker run --rm --mount type=bind,source=$abs_s1c3,target=/out -it spdxgen:s1c3
docker run --rm --mount type=bind,source=$abs_s1c3,target=/out -it syft:s1c3
docker run --rm --mount type=bind,source=$abs_s1c3,target=/out -it trivy:s1c3


read -p "Run complete. Press any key to finish. . ."
