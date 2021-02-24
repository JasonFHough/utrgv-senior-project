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
    gcc

# Download wiringPi repo
RUN git clone https://github.com/WiringPi/WiringPi.git wiringPi

# Build/Compile wiringPi
RUN cd wiringPi && ./build

# Compile motor.cpp
RUN make