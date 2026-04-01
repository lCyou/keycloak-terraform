# Terraform Outputs
# terraform applyやterraform outputで確認できる情報を定義します

output "realm_id" {
  description = "Master realm ID"
  value       = keycloak_realm.master.id
}

output "realm_name" {
  description = "Master realm name"
  value       = keycloak_realm.master.realm
}

output "keycloak_url" {
  description = "Keycloak server URL"
  value       = var.keycloak_url
}

# Example: Client outputs
# output "example_client_id" {
#   description = "Example client ID"
#   value       = keycloak_openid_client.example_backend.client_id
# }

# output "example_client_secret" {
#   description = "Example client secret"
#   value       = keycloak_openid_client.example_backend.client_secret
#   sensitive   = true
# }
