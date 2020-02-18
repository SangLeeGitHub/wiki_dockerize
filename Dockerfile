# From the node docker image 
FROM node:latest
MAINTAINER sanghlee@hotmail.ca

# Install nginx
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
 apt-get -y install apt-utils  && \
 apt-get -y install nginx && \
 yarn global add serve

# Install go
RUN curl https://dl.google.com/go/go1.13.8.linux-amd64.tar.gz | tar -xz && \
 mv go /usr/local

# Prepare working folder
RUN mkdir -p /home/node/app && chown -R node:node /home/node/app
WORKDIR /home/node/app

# Cloning the Web App Backend from the Git
RUN git clone https://github.com/hotdeveloper/wiki_with_go.git backend
RUN chown -R node:node /home/node/app/backend

# Cloning the Web App Frontend from the Git
RUN git clone https://github.com/hotdeveloper/wiki_client.git frontend
RUN chown -R node:node /home/node/app/frontend

# Configure nginx
RUN rm -rf /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/

# Shell script for launching the nginx and the web app
COPY run.sh /home/node/app/

# Build web app
ENV PATH=$PATH:/usr/local/go/bin
USER node
WORKDIR /home/node/app/frontend
RUN npm install
RUN npm run build
WORKDIR /home/node/app/backend
RUN go build

# Expose nginx port to the world.
EXPOSE 8080

# Launching the Web App and Nginx
WORKDIR /home/node/app
USER root
CMD ["sh", "run.sh"]