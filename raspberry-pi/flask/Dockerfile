# Use the Python3.7.5 container image
FROM python:3.7.5-stretch

# Set the working directory
WORKDIR /SmartBlindServer

# Copy the current directory's contents into the container
ADD . /SmartBlindServer

# Upgrade pip
RUN pip install --upgrade pip

# Install dependencies
RUN pip install -r requirements.txt

# Install SmartBlindServer Python package
RUN pip install .

# Start uWSGI
CMD ["uwsgi", "app.ini"]