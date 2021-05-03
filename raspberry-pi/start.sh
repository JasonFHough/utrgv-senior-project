# Sample Usage: bash start.sh

# Create sim links for uwsgi and pip commands so that they can be used with sudo
sudo ln -s $(which uwsgi) /usr/bin/uwsgi
sudo ln -s $(which pip) /usr/bin/pip

# ---- C LIBRARY ----

# Compile C library motor code
make clean -C MotorControl
make -C MotorControl

# ---- PYTHON / FLASK ----

# Ensure Python Flask API has all dependencies installed
pip install -r flask/requirements.txt
sudo /home/$(whoami)/.pyenv/shims/pip uninstall SmartBlindServer -y && sudo /home/$(whoami)/.pyenv/shims/pip install flask/

# ---- NGINX ----

# Use custom configuration file
sudo cp nginx/nginx_local.conf /etc/nginx/nginx.conf
sudo cp nginx/nginx_local.conf /etc/nginx/sites-available/SmartBlindServer
sudo ln -s /etc/nginx/sites-available/SmartBlindServer /etc/nginx/sites-enabled/
sudo unlink /etc/nginx/sites-enabled/default

# Restart nginx to apply configuration changes
sudo service nginx restart

# ---- UWSGI ----

# Start uWSGI
sudo systemctl start SmartBlindServer