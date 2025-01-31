data "aws_ami" "GanaDevOps" {

	most_recent      = true
    owners = ["973714476881"]  # owner ID for this ami (we can get this info from ami details)
	
	filter {
		name   = "name"
		values = ["RHEL-9-DevOps-Practice"]
	}
	
	filter {
		name   = "root-device-type"
		values = ["ebs"]
	}

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}


data "aws_route53_zone" "My_hosted_zone" {
    name = "ganeshdevops.space"
    private_zone = false
}