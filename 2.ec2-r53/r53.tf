data "aws_route53_zone" "my_hosted_zone" {
  name         = "ganeshdevops.space"
  private_zone = false
}


resource "aws_route53_record" "TestVmRecord" {
  zone_id         = data.aws_route53_zone.my_hosted_zone.id
  name            = "ganeshdevops.space"
  type            = "A"
  ttl             = 1
  records         = [aws_instance.TestVm.public_ip]
  allow_overwrite = true
}