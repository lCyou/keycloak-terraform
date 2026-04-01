# Keycloak Roles Configuration
# このファイルはRealm RoleとClient Roleを管理します

# Example: Realm Role
# resource "keycloak_role" "example_realm_role" {
#   realm_id    = keycloak_realm.master.id
#   name        = "example-role"
#   description = "Example realm role"
# }

# Example: Client Role
# resource "keycloak_role" "example_client_role" {
#   realm_id    = keycloak_realm.master.id
#   client_id   = keycloak_openid_client.example_backend.id
#   name        = "example-client-role"
#   description = "Example client role"
# }

# Example: Composite Role (他のロールを含むロール)
# resource "keycloak_role" "composite_role" {
#   realm_id    = keycloak_realm.master.id
#   name        = "composite-role"
#   description = "Composite role that includes other roles"
#   
#   composite_roles = [
#     keycloak_role.example_realm_role.id,
#   ]
# }

# 既存のロールをimportする場合:
# 1. Keycloak Admin Consoleでロールの詳細を確認
# 2. 上記のテンプレートをコピーしてコメント解除
# 3. ロール情報を実際の値に変更
# 4. Realm Role: terraform import keycloak_role.example_realm_role master/<role_name>
# 5. Client Role: terraform import keycloak_role.example_client_role master/<client_id>/<role_name>

# 注意: デフォルトロール (offline_access, uma_authorization等) は通常importしない
