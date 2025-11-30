variable "aws_region" {
    type = string
    defauld = "us-east-2"
}

variable "instance_type" {
    type = string
    defauld = "t2.micro"
}

variable "docker_image" {
    type = string
}