FROM ubuntu:15.04
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

# Install utilities
RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale && \
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
	wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jdk-8u77-linux-x64.tar.gz && \
	mkdir /opt/jdk && \
	tar -zxf jdk-8u77-linux-x64.tar.gz -C /opt/jdk && \
	rm jdk-8u77-linux-x64.tar.gz && \
	update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_77/bin/java 100 && \
	update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_77/bin/javac 100

#Install Java 32bit
RUN \
	wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jdk-8u77-linux-i586.tar.gz && \
        mkdir /opt/jdk-i586 && \
	tar -zxf jdk-8u77-linux-i586.tar.gz -C /opt/jdk-i586 && \
	rm jdk-8u77-linux-i586.tar.gz && \
	update-alternatives --install /usr/bin/java-i586 java-i586 /opt/jdk-i586/jdk1.8.0_77/bin/java 100 && \
	update-alternatives --install /usr/bin/javac-i586 javac-i586 /opt/jdk-i586/jdk1.8.0_77/bin/javac 100

#Install Leinigen
RUN \
	if [ ! -d "bin"]; then mkdir bin; fi && \
	wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O bin/lein && \
	chmod a+x bin/lein && \
	export PATH=$PATH:bin && \
	bash lein

# Install and configure CouchDB 1.6.0 requirements
RUN \
    	DEBIAN_FRONTEND=noninteractive \
	apt-get update && \
	apt-get install -y --force-yes \
    	erlang-dev \
    	erlang-manpages \
    	erlang-base-hipe \
    	erlang-eunit \
    	erlang-nox \
    	erlang-xmerl \
    	erlang-inets \
    	libmozjs185-dev \
    	libicu-dev \
    	libcurl4-gnutls-dev \
    	libtool

# Build CouchDB
RUN \
    	cd /tmp && \
    	wget http://mirror.switch.ch/mirror/apache/dist/couchdb/source/1.6.1/apache-couchdb-1.6.1.tar.gz && \
    	tar xzvf apache-couchdb-1.6.1.tar.gz && \
    	cd apache-couchdb-1.6.1 && \
    	./configure && \
    	make && \
    	make install && \
    	sed -e 's/^bind_address = .*$/bind_address = 0.0.0.0/' -i /usr/local/etc/couchdb/default.ini && \
    	sed -e 's/^database_dir = .*$/database_dir = \/data/' -i /usr/local/etc/couchdb/default.ini && \
    	sed -e 's/^view_index_dir = .*$/view_index_dir = \/data/' -i /usr/local/etc/couchdb/default.ini && \
    	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Tune CouchDB Config
RUN \
	sed -i 's/level = info/level = warning/' /usr/local/etc/couchdb/default.ini

# Provision CouchDB user with respective rights
RUN \
	adduser --system \
        --home /usr/local/var/lib/couchdb \
        --no-create-home \
        --shell /bin/bash \
        --group --gecos \
        "CouchDB Administrator" couchdb
RUN \
	chown -R couchdb:couchdb /usr/local/etc/couchdb && \
	chown -R couchdb:couchdb /usr/local/var/lib/couchdb && \
	chown -R couchdb:couchdb /usr/local/var/log/couchdb && \
	chown -R couchdb:couchdb /usr/local/var/run/couchdb
RUN \
	chmod 0770 /usr/local/etc/couchdb && \
	chmod 0770 /usr/local/var/lib/couchdb && \
	chmod 0770 /usr/local/var/log/couchdb && \
	chmod 0770 /usr/local/var/run/couchdb

# Install 32 bit compability layer
RUN apt-get update && apt-get install -y --force-yes libc6-i386 lib32z1 lib32ncurses5

# Command to run
CMD ["/bin/bash"]

# Expose listen port
EXPOSE 5984

# Expose our data, logs and configuration volumes
VOLUME ["/data", "/usr/local/var/log/couchdb", "/usr/local/etc/couchdb"]
