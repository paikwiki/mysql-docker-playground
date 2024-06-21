#!/bin/bash

if docker ps --format '{{.Names}}' | grep -q '^mysql-container$'; then
    echo "Stopping and removing mysql-container..."
    docker stop mysql-container && \
    docker rm mysql-container
else
    echo "mysql-container is not running."
fi
