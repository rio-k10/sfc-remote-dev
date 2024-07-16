#!/bin/bash

set -e
sudo apt update
sudo apt install openjdk-8-jdk
sudo update-java-alternatives --set java-1.8.0-openjdk-amd64
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/
export PATH=$PATH:$JAVA_HOME
java -version