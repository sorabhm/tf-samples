data "template_file" "cidr_subnets" {
    count = local.subnet_count

    template = "$${cidrsubnet(vpc_cidr,8,current_count)}"

    vars = {
        vpc_cidr = local.cidr_block
        current_count = count.index
    }
}

output "cidrblocks" {
    value = data.template_file.cidr_subnets.*.rendered
}