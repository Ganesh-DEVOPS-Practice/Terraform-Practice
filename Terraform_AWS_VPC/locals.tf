# locals is used to provide variables with expression

locals {
  resource_name = "${var.project_name}-${var.environment}"  # we get expense-dev like that for all resources.
  az_names = slice(data.aws_availability_zones.available.names,0,2)  # will give list of avilable names, slice will cut list based on index -> start: 0, end: n+1 (end is excluded)
}