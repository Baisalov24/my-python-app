data "aws_ami" "ubutu" {
    most_recent = true

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
    }
    owners = ["099720109477"] # Canonical
}

resource "aws_instance" "docker_ec2" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type

    vpc_security_group_ids = [aws_security_group.sg.id]

     user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              sudo docker run -d -p 5000:5000 ${var.docker_image}
              EOF

    tags = {
        Name = "DockerAppEC2"
    }
}

resource "aws_security_group" "sg" {
    name = "docker-sg"
    description = "Allow HTTP 5000"
    
    ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}