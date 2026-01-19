#!/bin/bash

# --- Configuration ---
# The directory containing the docker-compose.yaml and Dockerfile
DOCKER_DIR="${HOME}/ros2_cyclone_dds"
# ---------------------

echo "🚀 Starting Docker rebuild and restart process..."
echo "---"

# 1. Navigate to the Docker directory
echo "➡️ Changing directory to: $DOCKER_DIR"
#cd "$DOCKER_DIR" || { echo "Error: Failed to change directory. Exiting."; exit 1; }

# 2. Rebuild the service image
# --no-cache: forces a complete rebuild (optional, but good for ensuring fresh start)
# --build: tells docker-compose to rebuild the image before starting/creating the container
echo "🏗️ Rebuilding the Docker image for service: $SERVICE_NAME"
docker build -t ros2_cyclone_dds:test .

# Note: Since the Dockerfile is in the same directory as the docker-compose.yaml,
# docker-compose will find it automatically based on the 'build' context in the YAML.
#if ! docker compose up -d --no-deps --build "$SERVICE_NAME"; then
#    echo "❌ ERROR: Docker image rebuild or container start failed!"
#    echo "---"
#    exit 1
#fi

echo "---"
echo "🎉 Build finished successfully!"
