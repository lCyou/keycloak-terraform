variable "keycloak_url" {
  description = "Proxmox上のKeycloakエンドポイント"
  type        = string
}

variable "keycloak_client_id" {
  description = "Keycloak client ID for authentication"
  type        = string
  default     = "terraform-manage"
}

variable "keycloak_client_secret" {
  description = "Keycloak client secret"
  type        = string
  sensitive   = true
}
