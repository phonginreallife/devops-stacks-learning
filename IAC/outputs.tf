output "fe_dns_name" {
  value = module.frontend.fe_dns_name
}
output "db_password" {
  value     = module.backend.db_password
  sensitive = true
}