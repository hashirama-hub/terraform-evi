#VPC
resource "aws_vpc" "evi-prod" {
    cidr_block = var.CIRD_VPC
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      Name = "EVI VPC PROD"
    }

}

#Subnet
resource "aws_subnet" "evi_prod_public_1a" {
    vpc_id = aws_vpc.evi-prod.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
      Name = "EVI Subnet Public 1a"
    }

}

resource "aws_subnet" "evi_prod_public_1b" {
    vpc_id = aws_vpc.evi-prod.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1b"
    tags = {
      Name = "EVI Subnet Public 1b"
    }
    
}

resource "aws_subnet" "evi_prod_private_1a" {
    vpc_id = aws_vpc.evi-prod.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "EVI Private Subnet 1a"
    }
    
}
resource "aws_subnet" "evi_prod_private_1b" {
    vpc_id = aws_vpc.evi-prod.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "EVI Private Subnet 1b"
    }
    
}

resource "aws_subnet" "evi_subnet_database_1a" {
  vpc_id = aws_vpc.evi-prod.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "EVI Database Subnet 1a"
  }
  
}

resource "aws_subnet" "evi_subnet_database_1b" {
  vpc_id = aws_vpc.evi-prod.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "EVI Database Subnet 1b"
  }
  
}

#Internet Gateway

resource "aws_internet_gateway" "evi_internet_gateway" {
    vpc_id = aws_vpc.evi-prod.id
    tags = {
      Name = "EVI Internet Gateway"
    }
}

#Route Table and Associations
resource "aws_route_table" "evi_public_route_table" {
    vpc_id = aws_vpc.evi-prod.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.evi_internet_gateway.id

    }
    tags = {
      Name = "EVI Public Route Table"
    }
  
}

resource "aws_route_table_association" "evi-assoc-rt-public-1a" {
    route_table_id = aws_route_table.evi_public_route_table.id
    subnet_id = aws_subnet.evi_prod_public_1a.id
  
}

resource "aws_route_table_association" "evi-assoc-rt-public-1b" {
    route_table_id = aws_route_table.evi_public_route_table.id
    subnet_id = aws_subnet.evi_prod_public_1b.id
  
}

resource "aws_route_table" "evi_private_route_table" {
    vpc_id = aws_vpc.evi-prod.id
    tags = {
        Name = "EVI Private Route Table"
    }
  
}

resource "aws_route_table_association" "evi-assoc-rt-private-1a" {
    route_table_id = aws_route_table.evi_private_route_table.id
    subnet_id = aws_subnet.evi_prod_private_1a.id
  
}

resource "aws_route_table_association" "evi-assoc-rt-private-1b" {
    route_table_id = aws_route_table.evi_private_route_table.id
    subnet_id = aws_subnet.evi_prod_private_1b.id
  
}

resource "aws_route_table" "evi-rtb-database" {
  vpc_id = aws_vpc.evi-prod.id
  tags = {
    Name = "EVI Database Route Table"
  }
  
}
resource "aws_route_table_association" "evi-rtb-ass-database-1a" {
  route_table_id = aws_route_table.evi-rtb-database.id
  subnet_id = aws_subnet.evi_subnet_database_1a.id
  
}
resource "aws_route_table_association" "evi-rtb-ass-database-1b" {
  route_table_id = aws_route_table.evi-rtb-database.id
  subnet_id = aws_subnet.evi_subnet_database_1b.id
  
}

# resource "aws_route" "evi_route_database" {
#   route_table_id = aws_route_table.evi-rtb-database.id
#   destination_cidr_block = "10.0.0.0/16"

# }
