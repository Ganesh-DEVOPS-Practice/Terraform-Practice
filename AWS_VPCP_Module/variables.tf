variable "project_name" {  # mandatory to provide by user
    type = string
}

variable "environment" {  # mandatory to provide by user
    type = string
}


variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"    # this var is optional as we have default value
}


variable "enable_dns_hostnames" {
    type = bool
    default = true
}


# optional to pass values
variable "common_tags" {
    type = map
    default = {}
}

# when user used this module we can know in which proj and env this module is used.

# optional to pass values because we passed default as empty, we dont mention default then it will become mandatory var
variable "vpc_tags" {
    type = map
    default = {}
}

variable "igw_tags" {
    type = map
  default = {}
}

variable "public_subnet_tags" {
  type = map
  default = {}
}

variable "public_subnet_cidrs" {
    type = list
    validation { 
      condition = length(var.public_subnet_cidrs) == 2
      error_message = "please provide exactly 2 valid public subnet CIDRs"
    }
}


variable "private_subnet_tags" {
  type = map
  default = {}
}

variable "private_subnet_cidrs" {
    type = list
    validation { 
      condition = length(var.private_subnet_cidrs) == 2
      error_message = "please provide exactly 2 valid private subnet CIDRs"
    }
}


variable "database_subnet_tags" {
  type = map
  default = {}
}

variable "database_subnet_cidrs" {
    type = list
    validation { 
      condition = length(var.database_subnet_cidrs) == 2
      error_message = "please provide exactly 2 valid private subnet CIDRs"
    }
}


variable "db_subnet_group_tags" {
  type = map
  default = {}
}


variable "nat_gateway_tags" {
  type = map
  default = {}
}


variable "public_route_table_tags" {
  type = map
  default = {}
}

variable "private_route_table_tags" {
  type = map
  default = {}
}

variable "database_route_table_tags" {
  type = map
  default = {}
}