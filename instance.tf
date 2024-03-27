# Creating Public Instance
resource "aws_instance" "pub" {
  ami           = "ami-05a5bb48beb785bf1"  # Example AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = aws_key_pair.project.key_name
  security_groups = [aws_security_group.mysg.id]

  tags = {
    Name = "pub"
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"  # Replace with the appropriate username for your EC2 instance
    private_key = file("~/.ssh/id_rsa")  # Replace with the path to your private key
    host        = self.public_ip
  }

  provisioner "file" {
    source = "/home/garvit/Grras/web.sh"
    destination = "/home/ec2-user/web.sh"
    
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo chmod a+x /home/ec2-user/web.sh",
      "sh /home/ec2-user/web.sh"
     ]
  }

}

# Creating Private Instance
resource "aws_instance" "pvt" {
  ami           = "ami-05a5bb48beb785bf1"  # Example AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id
  key_name      = aws_key_pair.project.key_name
  security_groups = [aws_security_group.mysg.id]
  user_data = <<-EOF
   #!/bin/bash
   yum install mariadb -y
   EOF

  tags = {
    Name = "pvt"
  }  
  
}