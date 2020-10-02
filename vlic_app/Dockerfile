# Build instructions
# sudo docker build -t vlic/vlic_app:v6 .
# sudo docker tag vlic/vlic_app:v6 hub5.planet-rocklog.com:5000/vlic/vlic_app:v6
# sudo docker push vlic/vlic_app:v6 hub5.planet-rocklog.com:5000/vlic/vlic_app:v6

FROM vlic/vlic_base:v6
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

##########################################
#Additional Deps for the VLIC hemisphere
##########################################

RUN \
    apt-get update && \
    apt-get install -y --force-yes texlive texlive-latex-base texlive-latex-extra emacs24 lftp

##########################################
# CouchDB Dependency is need for building
# (tests) and running vlic applications
# with the CouchDB evictor
##########################################

RUN echo "deb http://packages.erlang-solutions.com/debian stretch contrib" > /etc/apt/sources.list.d/erlang-solutions.list
RUN wget -qO - http://packages.erlang-solutions.com/debian/erlang_solutions.asc | apt-key add -

# Update packages
RUN apt-get update

# Install dependencies
RUN apt-get install build-essential curl libmozjs185-1.0 libmozjs185-dev libcurl4-openssl-dev libicu-dev wget curl

# Install older version of erlang for couch
RUN \
    	DEBIAN_FRONTEND=noninteractive \
        apt-get update && \
        apt-get install install -y --force-yes erlang-dev=1:17.0 erlang-base=1:17.0 erlang-crypto=1:17.0 \
                      erlang-nox=1:17.0 erlang-inviso=1:17.0 erlang-runtime-tools=1:17.0 \
                      erlang-inets=1:17.0 erlang-edoc=1:17.0 erlang-syntax-tools=1:17.0 \
                      erlang-xmerl=1:17.0 erlang-corba=1:17.0 erlang-mnesia=1:17.0 \
                      erlang-os-mon=1:17.0 erlang-snmp=1:17.0 erlang-ssl=1:17.0 \
                      erlang-public-key=1:17.0 erlang-asn1=1:17.0 erlang-ssh=1:17.0 \
                      erlang-erl-docgen=1:17.0 erlang-percept=1:17.0 erlang-diameter=1:17.0 \
                      erlang-webtool=1:17.0 erlang-eldap=1:17.0 erlang-tools=1:17.0 \
                      erlang-eunit=1:17.0 erlang-ic=1:17.0 erlang-odbc=1:17.0 \
                      erlang-parsetools=1:17.0

# Install and configure CouchDB 1.6.0 requirements
RUN \
    	DEBIAN_FRONTEND=noninteractive \
	apt-get update && \
	apt-get install -y --force-yes \
    	libmozjs185-dev \
    	libicu-dev \
    	libcurl4-gnutls-dev \
    	libtool

# Build CouchDB
RUN \
    	cd /tmp && \
    	wget https://archive.apache.org/dist/couchdb/source/1.6.1/apache-couchdb-1.6.1.tar.gz && \
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
