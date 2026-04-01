# Keycloak Identity Providers Configuration
# このファイルは外部Identity Provider (Google, GitHub, SAML等) を管理します

# Example: Google Identity Provider
# resource "keycloak_oidc_google_identity_provider" "google" {
#   realm             = keycloak_realm.master.id
#   alias             = "google"
#   client_id         = "YOUR_GOOGLE_CLIENT_ID"
#   client_secret     = "YOUR_GOOGLE_CLIENT_SECRET"
#   trust_email       = true
#   store_token       = false
#   
#   extra_config = {
#     syncMode = "IMPORT"
#   }
# }

# Example: GitHub Identity Provider
# resource "keycloak_oidc_identity_provider" "github" {
#   realm             = keycloak_realm.master.id
#   alias             = "github"
#   provider_id       = "github"
#   client_id         = "YOUR_GITHUB_CLIENT_ID"
#   client_secret     = "YOUR_GITHUB_CLIENT_SECRET"
#   trust_email       = false
#   store_token       = false
#   
#   extra_config = {
#     syncMode = "IMPORT"
#   }
# }

# Example: Generic OIDC Identity Provider
# resource "keycloak_oidc_identity_provider" "custom_oidc" {
#   realm                 = keycloak_realm.master.id
#   alias                 = "custom-oidc"
#   provider_id           = "oidc"
#   client_id             = "YOUR_CLIENT_ID"
#   client_secret         = "YOUR_CLIENT_SECRET"
#   authorization_url     = "https://provider.example.com/oauth/authorize"
#   token_url             = "https://provider.example.com/oauth/token"
#   user_info_url         = "https://provider.example.com/oauth/userinfo"
#   trust_email           = true
#   store_token           = false
#   
#   extra_config = {
#     syncMode = "IMPORT"
#   }
# }

# Example: SAML Identity Provider
# resource "keycloak_saml_identity_provider" "saml" {
#   realm                      = keycloak_realm.master.id
#   alias                      = "saml-idp"
#   entity_id                  = "https://saml-provider.example.com/entity-id"
#   single_sign_on_service_url = "https://saml-provider.example.com/sso"
#   
#   extra_config = {
#     syncMode = "IMPORT"
#   }
# }

# 既存のIdentity Providerをimportする場合:
# 1. Keycloak Admin ConsoleでIdentity Providerの詳細を確認
# 2. 上記のテンプレートをコピーしてコメント解除
# 3. プロバイダー情報を実際の値に変更
# 4. terraform import keycloak_oidc_identity_provider.google master/google
#    (aliasがgoogleの場合)

# 注意: client_secret等の機密情報は、secrets.tfvarsやvault等で管理することを推奨
