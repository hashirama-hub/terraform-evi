resource "aws_instance" "ec2_nat" {
    subnet_id = aws_subnet.evi_prod_public_1a.id
    security_groups = [ aws_security_group.sg_ec2_nat.id ]
    ami = "ami-0ebfd941bbafe70c6"
    associate_public_ip_address = true
    instance_type = "t3.micro"
    key_name = "terraform"
    user_data = <<-EOF
            #!/bin/bash
            echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
            sysctl -p
            yum install -y iptables-services
            iptables -t nat -A POSTROUTING -o ens5 -j MASQUERADE
            iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
            service iptables save
            EOF
    
    tags = {
      Name = "EVI NAT Instance"
    }
    source_dest_check = false 
}



resource "aws_route" "outbound-nat-route" {
    route_table_id = aws_route_table.evi_private_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    network_interface_id = aws_instance.ec2_nat.primary_network_interface_id
  
}