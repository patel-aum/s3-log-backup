provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "docker_server" {
  ami           = "ami-078264b8ba71bc45e"  
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              # Install Docker
              yum update -y

              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user
              yum install git
              # Install AWS CLI
              curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
              unzip awscliv2.zip
              sudo ./aws/install
              EOF

  tags = {
    Name = "Docker-Logging-Instance"
  }
  key_name = "Linux-pair"  
}

resource "aws_s3_bucket" "logs_bucket" {
  bucket = "docker-container-logs-bucket"
}

output "instance_ip" {
  value = aws_instance.docker_server.public_ip
}

output "s3_bucket" {
  value = aws_s3_bucket.logs_bucket.bucket
}

