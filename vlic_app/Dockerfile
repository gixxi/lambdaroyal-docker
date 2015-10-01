FROM ubuntu:15.04
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

##########################################
#Install Java
##########################################
RUN \
	apt-get install -y wget && \
	wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.tar.gz && \
	mkdir /opt/jdk && \
	tar -zxf jdk-8u60-linux-x64.tar.gz -C /opt/jdk && \
	rm jdk-8u60-linux-x64.tar.gz && \
	update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_60/bin/java 100 && \
	update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_60/bin/javac 100

##########################################
#Install Leinigen
##########################################
RUN \
	if [ ! -d "bin" ]; then mkdir bin; fi && \
	wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o bin/lein && \
	chmod a+x bin/lein && \
	export PATH=$PATH:bin && \
	bash lein

##########################################	
#Install CouchDB
##########################################

# install the ppa-finding tool
RUN apt-get install software-properties-common -y
# add the ppa
RUN add-apt-repository ppa:couchdb/stable -y
# update cached list of packages
RUN apt-get update -y
# remove any existing couchdb binaries
RUN apt-get remove couchdb couchdb-bin couchdb-common -yf
# see my shiny goodness - note the version number displayed and ensure its what you expect
RUN apt-get install -Vy couchdb

#Install git
RUN \
	apt-get install git

# Define default command.
CMD ["bash"]
