### Dockerfile for Wiki Web App under Nginx Reverse Proxy

#### 1. Cloning Git
`git clone https://github.com/hotdeveloper/wiki_dockerize.git`

`cd wiki_dockerize`

#### 2. Build Docker image
`docker build -t md-wiki:2019 .`

#### 3. Running the container
`docker run -d -ti -p 8080:8080 md-wiki:2019`

If you don't want to build the docker image with the Dockerfile,

`docker run -d -it -p 8080:8080 pileup/md-wiki:2019`

It uses a docker image that I pushed to the Docker Hub.

#### 4. Run the app
in Web browser

`localhost:8080`

If you use Docker for Windows, You have to use the VM’s IP address instead of the localhost.

#### 5. Dockerfile
The Dockerfile contains comments that comprises the image.
