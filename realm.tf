resource "keycloak_realm" "master" {
  realm             = "master"
  enabled           = true
  display_name      = "Keycloak"
  display_name_html = "<div class=\"kc-logo-text\"><span>Keycloak</span></div>"

  # Login settings
  login_with_email_allowed = true
  duplicate_emails_allowed = false
  reset_password_allowed   = false
  remember_me              = false
  verify_email             = false

  # Token settings
  access_code_lifespan        = "1m"
  default_signature_algorithm = "RS256"

  # Session settings
  sso_session_idle_timeout = "30m"
  sso_session_max_lifespan = "10h"
}
