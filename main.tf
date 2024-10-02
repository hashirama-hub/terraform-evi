resource "aws_instance" "ec2_nat" {
    subnet_id = aws_subnet.evi_prod_public_1b.id
    
  
}

