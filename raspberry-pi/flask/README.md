# SmartBlindServer

The Python package containing the Flask RESTful API logic that is utilized by the mobile app component of this project.

## Prerequisites
1. `export FLASK_APP=SmartBlindServer.app:main`
2. `export FLASK_ENV=development`

## Starting the Server (without nginx)

1. `flask run`

## Stopping the Server

1. Press `CTRL-C` to stop the terminal

## Endpoints

- GET `/api/v1/blind/status`
- PUT `/api/v1/blind/open`
- PUT `/api/v1/blind/close`
- GET `/api/v1/blind/percent`
- PUT `/api/v1/blind/percent?percentage=50`