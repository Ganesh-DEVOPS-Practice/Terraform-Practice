data "aws_ami" "RHEL_9" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }


  owners = ["973714476881"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.RHEL_9.id
  instance_type = var.instance_type
  
  tags = {
    Name = "TestVm-${var.environment}"
  }
}