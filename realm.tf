# Master Realm Configuration
# このファイルはmaster realmの基本設定を管理します
# 実際のimport後、terraform planの結果に基づいて調整が必要です

resource "keycloak_realm" "master" {
  realm             = "master"
  enabled           = true
  display_name      = "Keycloak"
  display_name_html = "<div class=\"kc-logo-text\"><span>Keycloak</span></div>"

  # Login settings
  login_with_email_allowed = true
  duplicate_emails_allowed = false
  reset_password_allowed   = true
  remember_me              = false
  verify_email             = false
  login_theme              = "keycloak"

  # Token settings
  access_code_lifespan = "1m"

  # Session settings
  sso_session_idle_timeout = "30m"
  sso_session_max_lifespan = "10h"

  # Security settings
  security_defenses {
    headers {
      x_frame_options                     = "SAMEORIGIN"
      content_security_policy             = "frame-src 'self'; frame-ancestors 'self'; object-src 'none';"
      content_security_policy_report_only = ""
      x_content_type_options              = "nosniff"
      x_robots_tag                        = "none"
      x_xss_protection                    = "1; mode=block"
      strict_transport_security           = "max-age=31536000; includeSubDomains"
    }
    brute_force_detection {
      permanent_lockout                = false
      max_login_failures               = 30
      wait_increment_seconds           = 60
      quick_login_check_milli_seconds  = 1000
      minimum_quick_login_wait_seconds = 60
      max_failure_wait_seconds         = 900
      failure_reset_time_seconds       = 43200
    }
  }

  # Internationalization
  internationalization {
    supported_locales = [
      "en",
      "ja",
    ]
    default_locale = "en"
  }
}
