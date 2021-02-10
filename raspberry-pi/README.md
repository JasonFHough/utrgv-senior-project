# Docker
For ease of use during deployment, the RPi server utilizes Docker to containerize all of the required components.

## Usage

### Install Docker

See Docker's offical [install documentation](https://docs.docker.com/get-docker/)

### Build the Container

Build Docker container: `docker-compose build`

### Start the Container

Start Docker container: `docker-compose up`

After Docker has started the container, the REST API will be accessible at `csci4390.ddns.net/api/v1/.../...`