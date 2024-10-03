resource "aws_security_group" "sg_ec2_nat" {
    name = "EVI Security EC2 NAT"
    description = "Security for EC2 NAT in EVI"
    vpc_id = aws_vpc.evi-prod.id

    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        security_groups = [ aws_security_group.Allow_IP_BAP.id ]
        description = "Allow IP From BAP"
    }
    # ingress {
    #     from_port = "8"
    #     to_port = "8"
    #     protocol = "icmp"
    #     cidr_blocks = [ aws_vpc.evi-prod.cidr_block ]
    #     description = "ICMP From Private Subnet"
    # }
    ingress {
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = [ aws_vpc.evi-prod.cidr_block ]
        description = "Allow traffic in VPC"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "Allow_IP_BAP" {
    vpc_id = aws_vpc.evi-prod.id
    description = "Just Allow IP From BAP"

    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = [var.bap-ip-1]
        description = "BAP IP"
    }
    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = [var.bap-ip-2]
        description = "BAP IP"
    }
    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = [var.bap-ip-3]
        description = "BAP IP"
    }

    egress {
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
}


resource "aws_security_group" "EVI_sg_alb" {
    name = "EVI Security Group ALB"
    vpc_id = aws_vpc.evi-prod.id

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = "0.0.0.0/0"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = "0.0.0.0/0"
    }

  
}