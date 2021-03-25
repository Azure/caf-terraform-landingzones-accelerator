output "objects" {
  value     = module.caf.objects
  sensitive = true
}

output "tfstates" {
  value     = module.caf.tfstates
  sensitive = true
}