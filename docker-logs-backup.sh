#!/bin/bash

# AWS S3 bucket name
S3_BUCKET="docker-container-logs-bucket"

# Directory to save logs locally before uploading to S3
LOG_DIR="/tmp/docker-logs"
mkdir -p $LOG_DIR

# Get a list of all running Docker containers
containers=$(docker ps --format '{{.Names}}')

# Loop through each container and collect logs
for container in $containers; do
    log_file="$LOG_DIR/${container}.log"
    
    # Explicitly redirect logs to the file and capture both stdout and stderr
    docker logs "$container" > "$log_file" 2>&1
    
    # Check if the log file contains data
    if [ -s "$log_file" ]; then
        echo "Logs collected for container: $container"
        echo "Contents of $log_file:"
        cat "$log_file"
    else
        echo "No logs found for container: $container"
    fi
    
    # Upload the log file to S3
    aws s3 cp "$log_file" s3://$S3_BUCKET/
done

