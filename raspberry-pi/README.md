# Docker
For ease of use during deployment, the RPi server utilizes Docker to containerize all of the required components.

## Prerequisites

1. [Configure a Static IP](https://www.raspberrypi.org/documentation/configuration/tcpip/) for the Raspberry Pi
2. Port forward port 80 to the assigned static IP address

## Raspberry Pi Setup

1. Change directory to home
   - `cd ~`
2. Update and upgrade apt-get
   - `sudo apt-get update && sudo apt-get upgrade`
3. Install git
   - `sudo apt-get install git`
4. Clone git repo
   - `git clone https://github.com/JasonFHough/utrgv-senior-project.git smart-blind`
5. Install docker
   - `curl -fsSL https://get.docker.com -o get-docker.sh`
   - `sudo sh get-docker.sh` 
6. Add non-root user to docker group
   - NOTE: Ensure current user is a non-root user
   - `sudo usermod -aG docker <your-user-name>`
7. Install pyenv and pyenv-virtualenv
   - `curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash`
   - Copy the following into `~/.bashrc`:
   ```bash
    export PATH="~/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
   ```
8. Create Python virtual environment
   - `sudo apt-get install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl`
   - `pyenv install -v 3.7.5`
   - `pyenv virtualenv 3.7.5 smart-blind-env`
   - `cd smart-blind/raspberry-pi`
   - `pyenv local smart-blind-env`
   - `pip install --upgrade pip`
9. Install docker-compose
    - `cd ~/smart-blind/raspberry-pi/flask`
    - `echo "cryptography==3.3.2" > /tmp/requirements.txt`
    - `pip install -U docker-compose -r /tmp/requirements.txt`
    - `rm /tmp/requirements.txt`
10. Start the server
    - `cd ~/smart-blind/raspberry-pi`
    - `docker-compose build`
    - `docker-compose up`

## Usage

Once Docker has started flask and nginx, the REST API will be accessible at: `csci4390.ddns.net/api/v1/.../...`