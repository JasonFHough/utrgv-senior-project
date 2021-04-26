# Nginx

Nginx acts as the web server and reverse proxy that exposes the Python Flask RESTful application

## `nginx_local.conf`
The configuration file for Nginx.

Defines: 
- The port to listen on.
- The public URL/IP to access the Flask application remotely.
- The file path of the `SmartBlindServer.sock`
- Lots of other web server stuff... 🙃
