resource "aws_instance" "TestVm" {
  ami                    = data.aws_ami.GanaDevOps.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [ 
      # below commands for docker installation
      "sudo dnf -y install dnf-plugins-core",
      "sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo",
      "sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
      "sudo systemctl enable --now docker",

      # "sudo dnf install nginx -y",     these for nginx
      # "sudo systemctl start nginx",
     ]

     # by default only docker group members can run docker commands, if our ec2-user need access then add to docker group
     # Note after adding docker as secondary group log out and then login to get that access reflected
   
  }
  tags = merge(
    var.Tags,
    {
      Name = "Ansible-Vm"
    }
  )
}