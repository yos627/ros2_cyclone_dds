#!/bin/bash

# --- Configuration ---
# The name of the specific service (container) you want to restart
SERVICE_NAME="run_container"
# ---------------------

echo "Removing any dangling docker container. . . "
docker rm ros2_cyclone_dds
sleep 1

echo "🚀 Starting Docker restart process..."
echo "---"

# Note: Since the Dockerfile is in the same directory as the docker-compose.yaml,
# docker-compose will find it automatically based on the 'build' context in the YAML.
if ! docker compose up -d --no-deps --build "$SERVICE_NAME"; then
    echo "❌ ERROR: Docker image rebuild or container start failed!"
    echo "---"
    exit 1
fi

# 3. Verify the container status
echo "✅ Image rebuild and container update complete."
echo "📋 Verifying container status for $SERVICE_NAME..."
docker compose ps "$SERVICE_NAME"

echo "---"
echo "🎉 Run finished successfully!"
