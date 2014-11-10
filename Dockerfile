FROM ubuntu:14.04
MAINTAINER James Turnbull <james@lovedthanlost.net>

RUN apt-get -qqy update
RUN apt-get -qqy install git nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Install reveal.js
WORKDIR /opt
RUN git clone https://github.com/hakimel/reveal.js.git presentation
WORKDIR /opt/presentation
RUN npm install -g grunt-cli
RUN npm install

# Install wetty
#RUN git clone https://github.com/krishnasrinivas/wetty
#WORKDIR /opt/presentation/wetty
#RUN npm install

# Add content
WORKDIR /opt/presentation
ADD slides/ /opt/presentation/slides/
ADD gfx /opt/presentation/gfx/
ADD index.html /opt/presentation/index.html
ADD init.js /opt/presentation/js/init.js
ADD himmel.css /opt/presentation/css/theme/himmel.css
ADD tomorrow.css /opt/presentation/lib/css/tomorrow.css
ADD Gruntfile.js /opt/presentation/Gruntfile.js
RUN sed -i "s/port: port/port: port,\n\t\t\t\t\thostname: \'\'/g" Gruntfile.js

EXPOSE 8000

CMD [ "grunt", "serve" ]
