FROM ubuntu:14.04
MAINTAINER James Turnbull <james@lovedthanlost.net>

RUN apt-get -qqy update
RUN apt-get -qqy install git nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Install reveal.js
WORKDIR /opt
RUN git clone https://github.com/hakimel/reveal.js.git presentation
WORKDIR /opt/presentation
RUN git checkout 2.6.2
RUN npm install -g grunt-cli
RUN npm install

# Install wetty
#RUN git clone https://github.com/krishnasrinivas/wetty
#WORKDIR /opt/presentation/wetty
#RUN npm install

# Add content
WORKDIR /opt/presentation
ADD base/index.html /opt/presentation/index.html
ADD base/Gruntfile.js /opt/presentation/Gruntfile.js
RUN sed -i "s/port: port/port: port,\n\t\t\t\t\thostname: \'\'/g" /opt/presentation/Gruntfile.js
ADD base/js/init.js /opt/presentation/js/init.js
ADD base/css/theme/himmel.css /opt/presentation/css/theme/himmel.css
ADD base/lib/css/tomorrow.css /opt/presentation/lib/css/tomorrow.css
ADD base/setup.sh /opt/presentation/setup.sh

# Volumes
VOLUME /opt/presentation/slides/
VOLUME /opt/presentation/gfx/


EXPOSE 8000

WORKDIR /opt/presentation
ENTRYPOINT /opt/presentation/setup.sh
