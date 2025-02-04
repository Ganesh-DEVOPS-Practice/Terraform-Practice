resource "aws_vpc_peering_connection" "peering" {
    count = var.is_peering_required ? 1 : 0
    vpc_id        = aws_vpc.main.id    # requestor vpc
    peer_vpc_id   = data.aws_vpc.default.id   # acceptor vpc
    auto_accept   = true  # as it is same Account it can be approved autoamatically if we use this flag
    # peer_owner_id = var.peer_owner_id  # account ID is optional

    tags = merge(var.common_tags,var.vpc_peering_tags,
    {
        Name = "${local.resource_name}-default"
    })
}


# create road from our vpc 
# create "route" from our public subnet to peering (default VPC)
resource "aws_route" "public_peering" {
  count = var.is_peering_required ? 1 : 0   # this block will work only if peering is true
  route_table_id            = aws_route_table.public.id  # in our vpc , public subnet route table id (so now we are connecting road from our vpc subnet to default vpc)
  destination_cidr_block    = data.aws_vpc.default.cidr_block  # target vpc cidr (default vpc is target here)
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id   # peering id
  #peering[count.index] because, peering resource is using count so by default resource names will be in list based on count, but we given count as "1", but that resource name will be inside list --> ["resourcename"], inorder to call it we need peering[count.index] --> where as count.index is refering 0 

}

# create road from default vpc
# create "route" from default subnet to peering (our vpc)
resource "aws_route" "default_peering" {
  count = var.is_peering_required ? 1 : 0   # this block will work only if peering is true
  route_table_id            = data.aws_route_table.main.route_table_id # in default VPC , main public subnet route table id (so now we are connecting road from default vpc subnet to our vpc)
  destination_cidr_block    = var.vpc_cidr  # target vpc cidr (our vpc is target here)
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id

}


