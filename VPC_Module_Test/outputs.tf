output "vpc_id_we_get_in_test_mod" {
  value = module.vpc.vpc_id
}

# output "az_info" {
#   value = module.vpc.az_info
# }


output "default_vpc_info"{
  value = module.vpc.default_vpc_info
}