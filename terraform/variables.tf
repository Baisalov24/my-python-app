variable "aws_region" {
    type = string
    default = "us-east-2"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "docker_image" {
    type = string
}