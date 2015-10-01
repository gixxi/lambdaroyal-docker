FROM vlic/vlic_base:v1
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

##########################################
#Startup Configuration
##########################################
ENV LEIN_ROOT=1
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
