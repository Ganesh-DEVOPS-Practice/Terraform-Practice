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