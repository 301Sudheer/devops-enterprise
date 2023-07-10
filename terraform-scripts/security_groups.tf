# Create security group for public instances
resource "aws_security_group" "public_sg" {
  name        = "Vprofile-PublicSecurityGroup"
  description = "Security group for public instances"
  vpc_id      = aws_vpc.vprofileapp_vpc.id  

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Vprofile-PublicSecurityGroup"
  }
}

# Create security group for private instances
resource "aws_security_group" "private_sg" {
  name        = "Vprofile-PrivateSecurityGroup"
  description = "Security group for private instances"
  vpc_id      = aws_vpc.vprofileapp_vpc.id  

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Vprofile-PrivateSecurityGroup"
  }
}