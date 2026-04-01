#!/bin/bash
# Keycloak Terraform Import Script
# 既存のKeycloakリソースをTerraform stateにインポートするスクリプト

set -e

echo "======================================"
echo "Keycloak Terraform Import Script"
echo "======================================"
echo ""

# 認証情報の確認
if [ ! -f "secrets.tfvars" ]; then
    echo "ERROR: secrets.tfvars が見つかりません"
    exit 1
fi

echo "ℹ️  このスクリプトは既存のKeycloakリソースをTerraform stateにインポートします"
echo "ℹ️  事前にterraform initを実行してください"
echo ""

# 1. Master Realm のインポート
echo "📦 Step 1: Master Realm をインポート"
echo "実行コマンド: terraform import -var-file=secrets.tfvars keycloak_realm.master master"
echo ""
read -p "Master Realmをインポートしますか? (y/N): " confirm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    terraform import -var-file=secrets.tfvars keycloak_realm.master master
    echo "✅ Master Realm インポート完了"
else
    echo "⏭️  Master Realm インポートをスキップ"
fi
echo ""

# 2. Clients のインポート
echo "📦 Step 2: Clients をインポート"
echo "ℹ️  Keycloak Admin Consoleで以下の情報を確認してください:"
echo "   - Clients → 対象のClient → Settings"
echo "   - Client IDとInternal UUID (URLに表示される) をメモ"
echo ""
echo "例: terraform import -var-file=secrets.tfvars keycloak_openid_client.example master/<client-uuid>"
echo ""
read -p "Clientをインポートしますか? (y/N): " confirm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    read -p "Terraformリソース名 (例: keycloak_openid_client.example_backend): " resource_name
    read -p "Client UUID: " client_uuid
    terraform import -var-file=secrets.tfvars "$resource_name" "master/$client_uuid"
    echo "✅ Client インポート完了"
else
    echo "⏭️  Client インポートをスキップ"
fi
echo ""

# 3. Users のインポート
echo "📦 Step 3: Users をインポート"
echo "ℹ️  Keycloak Admin Consoleで以下の情報を確認してください:"
echo "   - Users → 対象のUser → Details"
echo "   - User UUID (URLに表示される) をメモ"
echo ""
echo "例: terraform import -var-file=secrets.tfvars keycloak_user.example_user master/<user-uuid>"
echo ""
read -p "Userをインポートしますか? (y/N): " confirm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    read -p "Terraformリソース名 (例: keycloak_user.example_user): " resource_name
    read -p "User UUID: " user_uuid
    terraform import -var-file=secrets.tfvars "$resource_name" "master/$user_uuid"
    echo "✅ User インポート完了"
else
    echo "⏭️  User インポートをスキップ"
fi
echo ""

# 4. Groups のインポート
echo "📦 Step 4: Groups をインポート"
echo "ℹ️  Keycloak Admin Consoleで以下の情報を確認してください:"
echo "   - Groups → 対象のGroup"
echo "   - Group UUID (URLに表示される) をメモ"
echo ""
echo "例: terraform import -var-file=secrets.tfvars keycloak_group.example_group master/<group-uuid>"
echo ""
read -p "Groupをインポートしますか? (y/N): " confirm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    read -p "Terraformリソース名 (例: keycloak_group.example_group): " resource_name
    read -p "Group UUID: " group_uuid
    terraform import -var-file=secrets.tfvars "$resource_name" "master/$group_uuid"
    echo "✅ Group インポート完了"
else
    echo "⏭️  Group インポートをスキップ"
fi
echo ""

# 5. Roles のインポート
echo "📦 Step 5: Roles をインポート"
echo "ℹ️  Realm Role: master/<role-name>"
echo "ℹ️  Client Role: master/<client-id>/<role-name>"
echo ""
echo "例 (Realm Role): terraform import -var-file=secrets.tfvars keycloak_role.example_role master/example-role"
echo "例 (Client Role): terraform import -var-file=secrets.tfvars keycloak_role.client_role master/example-client/example-role"
echo ""
read -p "Roleをインポートしますか? (y/N): " confirm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    read -p "Terraformリソース名 (例: keycloak_role.example_role): " resource_name
    read -p "Import ID (例: master/example-role): " import_id
    terraform import -var-file=secrets.tfvars "$resource_name" "$import_id"
    echo "✅ Role インポート完了"
else
    echo "⏭️  Role インポートをスキップ"
fi
echo ""

# 6. Identity Providers のインポート
echo "📦 Step 6: Identity Providers をインポート"
echo "ℹ️  Keycloak Admin Consoleで以下の情報を確認してください:"
echo "   - Identity Providers → 対象のProvider"
echo "   - Alias をメモ"
echo ""
echo "例: terraform import -var-file=secrets.tfvars keycloak_oidc_identity_provider.google master/google"
echo ""
read -p "Identity Providerをインポートしますか? (y/N): " confirm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    read -p "Terraformリソース名 (例: keycloak_oidc_identity_provider.google): " resource_name
    read -p "Provider Alias: " alias
    terraform import -var-file=secrets.tfvars "$resource_name" "master/$alias"
    echo "✅ Identity Provider インポート完了"
else
    echo "⏭️  Identity Provider インポートをスキップ"
fi
echo ""

# 完了
echo "======================================"
echo "✅ インポート処理完了"
echo "======================================"
echo ""
echo "次のステップ:"
echo "1. terraform plan -var-file=secrets.tfvars を実行"
echo "2. 差分がある場合、.tfファイルを調整"
echo "3. terraform plan で差分が無くなることを確認"
echo ""
