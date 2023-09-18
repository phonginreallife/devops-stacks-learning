output "vpc" {
    value = aws_vpc.vpc
}

output "public_subnets" {
    value = aws_subnet.public_subnets[*].id
}

output "private_subnets" {
  value = aws_subnet.private_subnets[*].id
}
output "database_subnet_group" {
  value       = try(aws_db_subnet_group.database_subnets[0].id, null)
}

