# Create a VPC
resource "aws_vpc" "vprofileapp_vpc" {
  cidr_block       = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "VProfile-App-Vpc"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.vprofileapp_vpc.id

  tags = {
    Name = "VProfile-App-Igw"
  }
}


# Create Route Table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.vprofileapp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "VProfile-App-RouteTable"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
count          = length(aws_subnet.public_subnets)
subnet_id      = aws_subnet.public_subnets[count.index].id
route_table_id = aws_route_table.my_route_table.id
}



# Create Public Subnets
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.vprofileapp_vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zone[count.index] # Replace with your desired availability zone

  tags = {
    Name = "VprofileApp-PublicSubnet-${count.index}"
  }
}

# Create Private Subnets
resource "aws_subnet" "private_subnets" {
  count                   = length(var.private_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.vprofileapp_vpc.id
  cidr_block              = var.private_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zone[0]  # Replace with your desired availability zone

  tags = {
    Name = "VProfileApp-PrivateSubnet-${count.index}"
  }
}