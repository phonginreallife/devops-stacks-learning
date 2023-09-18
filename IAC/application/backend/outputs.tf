output "cluster" {
  value = module.eks
}
output "db_password" {
  value     = module.database.db_config
  sensitive = true
}