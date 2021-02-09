# SmartBlindServer

The Python package that holds the REST API logic to be used by the mobile app component of this project.

## Prerequisites
1. `export FLASK_APP=SmartBlindServer.app:main`
2. `export FLASK_ENV=development`

## Starting the Server

1. `flask run`

## Stopping the Server

1. Press `CTRL-C` to stop the terminal

## Endpoints

- GET `/api/v1/blind/status`
- PUT `/api/v1/blind/open`
- PUT `/api/v1/blind/close`