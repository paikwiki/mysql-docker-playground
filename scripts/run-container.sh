#!/bin/bash

if ! docker ps --format '{{.Names}}' | grep -q '^mysql-container$'; then
    echo "Starting mysql-container..."
    docker run -d -p 3306:3306 --name mysql-container mysql-image
else
    echo "mysql-container is already running."
fi
