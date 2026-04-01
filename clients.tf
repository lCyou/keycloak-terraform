# Keycloak Clients Configuration
# このファイルはOAuth/OIDCクライアントを管理します
# 実際の環境に合わせて、カスタムクライアントを追加してください

# Example: Confidential Client (Backend Application)
# resource "keycloak_openid_client" "example_backend" {
#   realm_id              = keycloak_realm.master.id
#   client_id             = "example-backend"
#   name                  = "Example Backend Application"
#   enabled               = true
#   access_type           = "CONFIDENTIAL"
#   
#   valid_redirect_uris = [
#     "http://localhost:8080/*",
#   ]
#   
#   web_origins = [
#     "http://localhost:8080",
#   ]
# }

# Example: Public Client (Frontend Application)
# resource "keycloak_openid_client" "example_frontend" {
#   realm_id              = keycloak_realm.master.id
#   client_id             = "example-frontend"
#   name                  = "Example Frontend Application"
#   enabled               = true
#   access_type           = "PUBLIC"
#   
#   standard_flow_enabled        = true
#   implicit_flow_enabled        = false
#   direct_access_grants_enabled = true
#   
#   valid_redirect_uris = [
#     "http://localhost:3000/*",
#   ]
#   
#   web_origins = [
#     "http://localhost:3000",
#   ]
# }

# 既存のクライアントをimportする場合:
# 1. Keycloak Admin Consoleでクライアントの詳細を確認
# 2. 上記のテンプレートをコピーしてコメント解除
# 3. クライアントIDやURIを実際の値に変更
# 4. terraform import keycloak_openid_client.example_backend master/<client_uuid>
