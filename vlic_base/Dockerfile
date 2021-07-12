# Build instructions
# sudo docker build -t vlic/vlic_base:v6 .

FROM debian:stretch
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

# Add 32bit architecture
RUN dpkg --add-architecture i386 && apt-get update

RUN \
    apt-get install -y --force-yes openjdk-8-jdk ca-certificates-java

RUN \
    apt-get install -y --force-yes openjdk-8-jdk:i386 && \
    update-alternatives --install /usr/bin/java-i586 java-i586 /usr/lib/jvm/java-8-openjdk-i386/bin/java 100 && \
    update-alternatives --install /usr/bin/javac-i586 javac-i586 /usr/lib/jvm/java-8-openjdk-i386/bin/javac 100

# Install utilities
RUN echo 'LANG="en_US.UTF-8"' > /etc/default/locale && \
    sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --force-yes \
    build-essential \
    software-properties-common \
    apt-transport-https \
    curl \
    wget \
    git \
    unzip \
    pwgen

#Install Leinigen
RUN \
	if [ ! -d "bin"]; then mkdir bin; fi && \
	wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O bin/lein && \
	chmod a+x bin/lein && \
	export PATH=$PATH:bin && \
	bash leinM