resource "aws_iam_role" "ec2_role" {
  name = "ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_ecr_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_security_group" "my_sg" {
  name        = "my-security-group"
  description = "Allow inbound traffic on ports 22 (SSH), 3000 (Frontend), and 8000 (Backend)"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
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

data "aws_ami" "latest_amazon_linux" {
  most_recent = true

  owners = ["amazon"]
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}
resource "aws_instance" "my_ec2" {
  ami             = "ami-0c02fb55956c7d316" 
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.my_key_pair.key_name
  security_groups = [aws_security_group.my_sg.name]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  user_data = <<-EOF
    #!/bin/bash
    # Actualización de sistema y Docker
    yum update -y
    yum install -y docker
    yum install -y git
    service docker start
    usermod -aG docker ec2-user
    
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    echo "export PATH=$PATH:/usr/local/bin" >> ~/.bashrc
    source ~/.bashrc

    # Clonar repositorio
    git clone https://github.com/Aquiles2001/devops-interview-ultimate-Aquiles-Lencina.git

    # Ejecutar docker-compose
    cd /home/ec2-user/devops-interview-ultimate-Aquiles-Lencina/prueba-2
    docker-compose up -d

  EOF

  tags = {
    Name = "My EC2 Instance"
  }
}

output "public_ip" {
  value = aws_instance.my_ec2.public_ip
}