# Use the stretch container image
FROM raspbian/stretch:latest

# Set the working directory
WORKDIR /MotorControl

# Copy the current directory's contents into the container
ADD . /MotorControl

# Install dependencies
RUN apt-get update && apt-get install -y \
    git-core \
    build-essential \
    gcc \
    unzip

# Download pigpiop repo
RUN wget https://github.com/joan2937/pigpio/archive/master.zip

# Unzip pigpio
RUN unzip master.zip

# Compile pigpio library
RUN cd pigpio-master && make

# Install python dependencies prior to installing pigpio library
RUN sudo apt install -y python-setuptools python3-setuptools

# Install pigpio library
RUN cd pigpio-master && sudo make install

# Compile C++ motor code and create .so file
RUN make