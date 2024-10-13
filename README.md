# s3-log-backup
# Docker Logs Backup to S3

This Bash script collects logs from all running Docker containers and uploads them to an AWS S3 bucket.

## Prerequisites

- **Docker**: Ensure Docker is installed and running.
- **AWS CLI**: Install and configure the AWS CLI. Run `aws configure` to set up your credentials.
- **S3 Bucket**: Premission to create an S3 bucket for log storage
