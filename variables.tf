variable "keycloak_url" {
  description = "Proxmox上のKeycloakエンドポイント"
  type        = string
}

variable "keycloak_client_id" {
  type    = string
  default = "admin-cli"
}

variable "keycloak_client_secret" {
  type      = string
  sensitive = true
}
