FROM vlic/vlic_base:v1
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

RUN \
 apt-get update && \
 apt-get install -y --force-yes npm && \
 npm install -g bower 

##########################################
#ecdsa keypair for json web tokens
##########################################
RUN \
 ssh-keygen -q -N "" -t ecdsa -f ~/.ssh/id_ecdsa

##########################################
#Startup Configuration
##########################################
ENV LEIN_ROOT=1
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
