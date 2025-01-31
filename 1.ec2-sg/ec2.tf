resource "aws_instance" "TestVm" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  tags = {
    Name = "Test-VM"
  }
}