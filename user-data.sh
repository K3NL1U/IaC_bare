#!/bin/bash
apt-get update
apt-get install -y docker.io
systemctl enable docker
systemctl start docker

# Allow time for Docker to start
sleep 5

docker run -d --restart unless-stopped -p 80:80 ${var.dockerhub_image}