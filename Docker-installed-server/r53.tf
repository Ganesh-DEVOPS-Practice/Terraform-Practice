resource "aws_route53_record" "r53-Record" {
    name = "ganeshdevops.space"
    zone_id = data.aws_route53_zone.My_hosted_zone.id
    type = "A"
    ttl = 1
    records = [aws_instance.TestVm.public_ip]
    allow_overwrite = true
}