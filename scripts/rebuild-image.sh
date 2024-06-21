#!/bin/bash

IMAGE_NAME="mysql-alpine"
TAG="latest"

# Find all image IDs with the specified name and tag
IMAGE_IDS=$(docker images -q ${IMAGE_NAME}:${TAG})

# Remove the old images
if [ -n "${IMAGE_IDS}" ]; then
    echo "Removing old images..."
    docker rmi -f ${IMAGE_IDS}
else
    echo "No old images to remove."
fi

# Build the new image and tag it with 'latest'
docker build -t ${IMAGE_NAME}:${TAG} .

# Check the new image ID
NEW_IMAGE_ID=$(docker images -q ${IMAGE_NAME}:${TAG})
echo "New image built with ID: ${NEW_IMAGE_ID}"

