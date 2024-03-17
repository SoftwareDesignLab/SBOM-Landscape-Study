# File: plugfest-mvn.Dockerfile
# Description: Setup plugfest enviroment for tools to be run in
#
# @author Derek Garcia
FROM eclipse-temurin:21-jdk

# apt setup
RUN apt update
RUN apt upgrade -y

# Install Utils
RUN apt install curl unzip git -y

# Working directory for Maven and Gradle setup
WORKDIR /opt

# Setup Maven 3.9.6
ENV M2_HOME=/opt/maven
ENV PATH="${PATH}:${M2_HOME}/bin"
RUN curl -sL https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz | tar xz
RUN ln -s apache-maven-3.9.6 maven

# Setup Gradle 8.6
#ENV GRADLE_HOME=/opt/gradle
#ENV PATH="${PATH}:${GRADLE_HOME}/bin"
#RUN wget -c https://services.gradle.org/distributions/gradle-8.6-bin.zip -P /tmp
#RUN unzip -d /opt /tmp/gradle-8.6-bin.zip
#RUN ln -s gradle-8.6 gradle

# Setup Node.js using nvm
ENV NVM_DIR=/root/.nvm
ENV PATH="${PATH}:/root/.nvm/versions/node/v20.11.0/bin/"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
RUN . $NVM_DIR/nvm.sh && nvm install --lts

# Reset working directory
WORKDIR /