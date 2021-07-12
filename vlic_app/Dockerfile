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


# Install 32 bit compability layer
RUN apt-get update && apt-get install -y --force-yes libc6-i386 lib32z1 lib32ncurses5

# Command to run
CMD ["/bin/bash"]