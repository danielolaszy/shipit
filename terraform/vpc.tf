resource "aws_vpc" "shipit_vpc" {
  cidr_block = "10.0.0.0/16"  # Define the CIDR block for the VPC
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.github_repository}-vpc"
  }
}

resource "aws_subnet" "shipit_subnet" {
  vpc_id     = aws_vpc.shipit_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.aws_region}${var.aws_availabilty_zone}"

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.github_repository}-subnet"
  }
}

resource "aws_internet_gateway" "shipit_gateway" {
  vpc_id = aws_vpc.shipit_vpc.id

  tags = {
    Name = "${var.github_repository}-gateway"
  }
}

resource "aws_route_table" "shipit_route_table" {
  vpc_id = aws_vpc.shipit_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shipit_gateway.id
  }

  tags = {
    Name = "${var.github_repository}-route-table"
  }

}

resource "aws_route_table_association" "shipit_subnet_association" {
  subnet_id      = aws_subnet.shipit_subnet.id
  route_table_id = aws_route_table.shipit_route_table.id
}


resource "aws_security_group" "shipit_security_group" {
  name        = "${var.github_repository}-security-group"
  description = "Allow inbound traffic"
  vpc_id      =  aws_vpc.shipit_vpc.id

  ingress {
    description = "Allow SSH from any IP address"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP from any IP address"
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
    Name = "${var.github_repository}-security-group"
  }
}