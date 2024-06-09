variable "statement" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "url" {
  type = string
}

resource "aws_instance" "in-pub" {
  ami           = "ami-0ca2e925753ca2fb4"
  instance_type = "t2.micro"
  user_data     = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install -y git
    sudo apt install -y python3.11
    git clone ${var.url}
    cd PythonSimple
    python calculate.py
  EOF
  tags = {
    Name = var.statement == "workflow_dispatch" ? var.instance_name : format("%s-%s", "prod", var.statement)
  }
}
