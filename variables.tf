variable "aws_region" {
  description = "The AWS region things are created in"
  type        = string
  default     = "us-east-1"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  type        = number
  default     = 2
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  type        = string
  default     = "bradfordhamilton/crystal_blockchain:latest"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  type        = number
  default     = 3000
}

variable "app_count" {
  description = "Number of docker containers to run"
  type        = number
  default     = 3
}

variable "health_check_path" {
  description = "Path to check for health of the service"
  type        = string
  default     = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  type        = number
  default     = 1024
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  type        = number
  default     = 2048
}

variable "project" {
  description = "The name of the project"
  type        = string
  default     = "Example Project"
}

variable "owner" {
  description = "The owner of the resource"
  type        = string
  default     = "Dru Jensen"
}
