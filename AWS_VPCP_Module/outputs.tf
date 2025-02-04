output "vpc_id" {
  value = aws_vpc.main.id
}

# we can see o/p of AZ
output "az_info" {
  value = data.aws_availability_zones.available
}