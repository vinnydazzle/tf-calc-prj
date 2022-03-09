#provider
provider "aws" {
  region = "us-east-2"
}

#Resource - VPC
resource "aws_vpc" "calc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = "calc-VPC"
  }
}


# Resource - internet gateway
resource "aws_internet_gateway" "calc-igw" {
  vpc_id = aws_vpc.calc.id

  tags = {
    Name = "calc-IGW"
  }
}
# Resource - calc PUBLIC SUBNET
resource "aws_subnet" "calc-pub-sn" {
  vpc_id                  = aws_vpc.calc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "calc-PUB-SUBNET"
  }
}

# Resource - calc PUBLIC ROUTE TABLE
resource "aws_route_table" "calc-pub-rt" {
  vpc_id = aws_vpc.calc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.calc-igw.id
  }
  tags = {
    Name = "calc-PUB-RT"
  }
}

# Resource - calc public route table - SUBNET ASSOCIATION- A
resource "aws_route_table_association" "calc-pub-asc-a" {
  subnet_id      = aws_subnet.calc-pub-sn.id
  route_table_id = aws_route_table.calc-pub-rt.id
}

