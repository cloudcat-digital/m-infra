output "aws_eip_ids" {
  value = aws_eip.nat.*.id
}

output "aws_eip_public_ips" {
  value = aws_eip.nat.*.public_ip
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "vpc_id" {
  value = module.vpc.vpc_id
}