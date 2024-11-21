#!/bin/bash

# Script to build and run a Docker container for a Jupyter Data Analysis project with volume mounts.

# Description:
# This script automates the process of building a Docker image and running a container for a Jupyter project.
# It mounts local directories to prevent data loss when the container exits.

# Usage:
# Save the script as `run_docker.sh`, make it executable (`chmod +x run_docker.sh`), and execute it:
# ./run_docker.sh [PROJECT_DIR] [DOCKER_IMAGE_NAME:TAG]
# Example:
# ./run_docker.sh /path/to/project jupyter_data_analysis:v1

# Parameters:
# - PROJECT_DIR: Directory where the Dockerfile is located. Default is the current working directory.
# - DOCKER_IMAGE: Name and tag for the Docker image. Default is `data_analysis:v1`.

# Default values
PROJECT_DIR=${1:-$(pwd)}   # Use the current directory if no argument is provided
DOCKER_IMAGE=${2:-data_analysis:v1}

# Local directories for mounting
NOTEBOOKS_DIR="$PROJECT_DIR/notebooks"
DATA_DIR="$PROJECT_DIR/data"

# Ensure notebooks and data directories exist locally
mkdir -p "$NOTEBOOKS_DIR" "$DATA_DIR"

# Navigate to the project directory
if [ -d "$PROJECT_DIR" ]; then
  echo "Navigating to project directory: $PROJECT_DIR"
  cd "$PROJECT_DIR" || { echo "Failed to navigate to $PROJECT_DIR"; exit 1; }
else
  echo "Error: Directory $PROJECT_DIR does not exist."
  exit 1
fi

# Build the Docker image
echo "Building Docker image: $DOCKER_IMAGE"
docker build -t "$DOCKER_IMAGE" . | tee docker_build.log

# Check if the build was successful
if [ $? -ne 0 ]; then
  echo "Docker build failed. Check docker_build.log for details."
  exit 1
fi

# Run the Docker container with volume mounts
echo "Running Docker container with volume mounts..."
docker run --rm -it \
  -p 8888:8888 \
  -v "$NOTEBOOKS_DIR:/notebooks" \
  -v "$DATA_DIR:/data" \
  "$DOCKER_IMAGE" | tee docker_run.log

# Check if the container ran successfully
if [ $? -ne 0 ]; then
  echo "Docker container failed to run. Check docker_run.log for details."
  exit 1
fi

echo "Docker container exited successfully."
