output "public_ip" {
    value = aws_instance.TestVm.public_ip
}

output "TestVm_Public_dns" {
    value = aws_instance.TestVm.public_dns
}