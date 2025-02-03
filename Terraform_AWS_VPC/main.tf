# Create VPC 
resource "aws_vpc" "main" { # main bz we create only one VPC
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames  # A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false.

  tags = merge(var.common_tags,var.vpc_tags,
    {
    Name = local.resource_name
    }
  )
}

# create IGW
resource "aws_internet_gateway" "main" { # main bz we create only one IGW
  vpc_id = aws_vpc.main.id  # IGW associate with vpc
  tags = merge(
    var.common_tags,
    var.igw_tags,
    {
        Name = local.resource_name
    }
  )
}

# create 2 public subnets (by using count )
resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidrs)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.public_subnet_cidrs[count.index]    # we pass list of 2 cidrs only (our req)
    availability_zone = local.az_names[count.index]
    map_public_ip_on_launch = true # allow only for public subnets 

    tags = merge(var.common_tags,var.public_subnet_tags,
    {
        Name = "${local.resource_name}-public-${local.az_names[count.index]}"
    }
    )
}


# create 2 private subnets (by using count )
resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidrs)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs[count.index]   # we pass list of 2 cidrs only (our req)
    availability_zone = local.az_names[count.index]

    tags = merge(var.common_tags,var.private_subnet_tags,
    {
        Name = "${local.resource_name}-private-${local.az_names[count.index]}"
    }
    )
}


# create 2 database subnets (by using count )
resource "aws_subnet" "database" {
    count = length(var.database_subnet_cidrs)
    vpc_id     = aws_vpc.main.id
    cidr_block = var.database_subnet_cidrs[count.index]    # we pass list of 2 cidrs only (our req)
    availability_zone = local.az_names[count.index]

    tags = merge(var.common_tags,var.database_subnet_tags,
    {
        Name = "${local.resource_name}-database-${local.az_names[count.index]}"
    }
    )
}


resource "aws_db_subnet_group" "db_group" {
  name = local.resource_name
  subnet_ids = aws_subnet.database[*].id     # it req list of subnets, [*] will get all values how many it can access

  tags = merge(var.common_tags,var.db_subnet_group_tags,
  {
    Name = local.resource_name
  })
}


# create a elastic ip
resource "aws_eip" "nat_eip" {   # it is creating elastic ip 
  domain   = "vpc"
}

resource "aws_nat_gateway" "main" {  # main because we create only one
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(var.common_tags,var.nat_gateway_tags,
  {
    Name = local.resource_name
  })

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}