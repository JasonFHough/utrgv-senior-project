# Nginx

Nginx acts as the web server and reverse proxy that exposes the Python Flask RESTful application

## `nginx.conf`
The configuration file for Nginx.

Defines: 
- The port to listen on.
- The public URL/IP to access the Flask application remotely. 
- The IP to proxy to - in this case Nginx is reverse proxying to 127.0.0.1 (localhost).
- Lots of other web server stuff... 🙃
