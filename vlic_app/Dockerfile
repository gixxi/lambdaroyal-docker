FROM vlic/vlic_base:v2
MAINTAINER Christian Meichsner <christian.meichsner@live.com>

RUN \
 apt-get update && \
 apt-get install -y --force-yes npm && \
 npm install -g bower && \
 ln -s /usr/bin/nodejs /usr/bin/node

##########################################
#Additional Deps for the VLIC hemisphere
##########################################

RUN \
    apt-get update && \
    apt-get install -y --force-yes texlive texlive-latex-base texlive-latex-extra emacs24 lftp

##########################################
#Startup Configuration
##########################################
ENV LEIN_ROOT=1