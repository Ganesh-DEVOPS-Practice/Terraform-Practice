output "vpc_id" {
  value = aws_vpc.main.id
}

# we can see o/p of AZ
output "az_info" {
  value = data.aws_availability_zones.available
}

# we can see o/p of default_vpc data
output "default_vpc_info" {
  value = data.aws_vpc.default
}

output "main_route_table_default_vpc_info" {
  value = data.aws_route_table.main
}