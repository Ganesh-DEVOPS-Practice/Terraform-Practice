data "aws_availability_zones" "available" {
  state = "available"  # it will give list of all available AZ in given region
}
# region will be taken from provider.tf (we have given there default region)



data "aws_vpc" "default"{
  default = true     # default will get default vpc data
}