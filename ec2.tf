# ec2 instance
resource "aws_instance" "calcweb" {
  ami                    = "ami-08b6f2a5c291246a0"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.calc-pub-sn.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = "ohio"
  tags = {
    Name = "Calc K8S WORKSTATION"
  }
}
