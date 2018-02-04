FROM debian:jessie
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

# Build instructions
# sudo docker build -t vlic/vlic_base:v4 .

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

#Install Java 64bit
RUN \
        wget --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz" && \
	mkdir -p /opt/jdk && \
	tar -zxf jdk-8u161-linux-x64.tar.gz -C /opt/jdk && \
	rm jdk-8u161-linux-x64.tar.gz

RUN \
        update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_161/bin/java 100 && \
        update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_161/bin/javac 100

#Install Java 32bit
RUN \
        wget --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-i586.tar.gz" && \
        mkdir -p /opt/jdk-i586 && \
	tar -zxf jdk-8u161-linux-i586.tar.gz -C /opt/jdk-i586 && \
	rm jdk-8u161-linux-i586.tar.gz
RUN \
	update-alternatives --install /usr/bin/java-i586 java-i586 /opt/jdk-i586/jdk1.8.0_161/bin/java 100 && \
	update-alternatives --install /usr/bin/javac-i586 javac-i586 /opt/jdk-i586/jdk1.8.0_161/bin/javac 100

#Install Leinigen
RUN \
	if [ ! -d "bin"]; then mkdir bin; fi && \
	wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O bin/lein && \
	chmod a+x bin/lein && \
	export PATH=$PATH:bin && \
	bash lein