# Assignment 2 - Dockerized Diagnostic CLI

## Build the image
docker build -t diagnostic-tool .

## Run commands
docker run --rm diagnostic-tool system
docker run --rm diagnostic-tool disk
docker run --rm diagnostic-tool network google.com
docker run --rm diagnostic-tool help

## Run with Docker Compose
docker compose run --rm diagnostic system
