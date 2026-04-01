# Keycloak Users and Groups Configuration
# このファイルはユーザーとグループを管理します

# Example: User
# resource "keycloak_user" "example_user" {
#   realm_id   = keycloak_realm.master.id
#   username   = "example.user"
#   enabled    = true
#   
#   email      = "example.user@example.com"
#   email_verified = true
#   first_name = "Example"
#   last_name  = "User"
#   
#   initial_password {
#     value     = "changeme"
#     temporary = true
#   }
# }

# Example: Group
# resource "keycloak_group" "example_group" {
#   realm_id = keycloak_realm.master.id
#   name     = "example-group"
# }

# Example: Group Membership
# resource "keycloak_group_memberships" "example_membership" {
#   realm_id = keycloak_realm.master.id
#   group_id = keycloak_group.example_group.id
#   
#   members = [
#     keycloak_user.example_user.username,
#   ]
# }

# 既存のユーザーをimportする場合:
# 1. Keycloak Admin Consoleでユーザーの詳細を確認
# 2. 上記のテンプレートをコピーしてコメント解除
# 3. ユーザー情報を実際の値に変更
# 4. terraform import keycloak_user.example_user master/<user_uuid>

# 注意: adminユーザーは通常importせず、Keycloakのデフォルトのまま運用することを推奨
