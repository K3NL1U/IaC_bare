variable "project_name" {
  type        = string
  description = "The name of the project."
  default     = "g360-compute-webtier"
}

variable "aws_region" {
  type        = string
  description = "The AWS region to create resources in."
  default     = "ap-southeast-2"
}

variable "instance_type" {
  type        = string
  description = "The EC2 instance's type."
  default     = "t3.micro"
}

variable "dockerhub_image" {
  description = "Docker Hub image name"
  type        = string
  default     = "k3nl1u/nginx-k3n:v0.1.0"
}

variable "asg_min_size" {
  description = "Minimum size of the Auto Scaling Group."
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum size of the Auto Scaling Group."
  type        = number
  default     = 2
}

variable "asg_desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group."
  type        = number
  default     = 2
}
