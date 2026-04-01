# Keycloak Terraform Configuration

このリポジトリはProxmox上で稼働しているKeycloak (v21+) をTerraformで管理するための設定ファイル群です。

## 📁 ファイル構成

```
keycloak-terraform/
├── provider.tf              # Keycloak provider設定
├── variables.tf             # 変数定義
├── secrets.tfvars          # 認証情報 (Git管理外)
├── realm.tf                # Master realm設定
├── clients.tf              # OAuthクライアント定義
├── users.tf                # ユーザー/グループ定義
├── roles.tf                # ロール定義
├── identity_providers.tf   # 外部IdP連携設定
├── outputs.tf              # 出力定義
├── import.sh               # Import実行スクリプト
└── README.md               # このファイル
```

## 🚀 セットアップ

### 前提条件

- Terraform v1.5.0以上
- Keycloak v21以上 (Quarkus版)
- Keycloakへのアクセス権限 (admin-cli client credentials)

### 1. 初期化

```bash
terraform init
```

### 2. 認証情報の設定

`secrets.tfvars` ファイルを確認し、以下の情報が正しく設定されていることを確認してください:

```hcl
keycloak_url           = "http://192.168.0.94:8080"
keycloak_client_secret = "YOUR_CLIENT_SECRET"
```

## 📥 既存リソースのインポート

既存のKeycloak設定をTerraform管理下に置くには、以下の手順でインポートを実行します。

### 方法1: インタラクティブスクリプトを使用

```bash
./import.sh
```

スクリプトの指示に従って、各リソースをインポートします。

### 方法2: 手動でインポート

#### Master Realmのインポート

```bash
terraform import -var-file=secrets.tfvars keycloak_realm.master master
```

#### Clientのインポート

1. Keycloak Admin Console → Clients → 対象のClient
2. URLからClient UUIDを確認 (例: `http://.../clients/xxxxx-xxxxx-xxxxx`)
3. 以下のコマンドを実行:

```bash
terraform import -var-file=secrets.tfvars keycloak_openid_client.example_backend master/<client-uuid>
```

#### Userのインポート

1. Keycloak Admin Console → Users → 対象のUser
2. URLからUser UUIDを確認
3. 以下のコマンドを実行:

```bash
terraform import -var-file=secrets.tfvars keycloak_user.example_user master/<user-uuid>
```

#### Groupのインポート

```bash
terraform import -var-file=secrets.tfvars keycloak_group.example_group master/<group-uuid>
```

#### Roleのインポート

Realm Role:
```bash
terraform import -var-file=secrets.tfvars keycloak_role.example_role master/<role-name>
```

Client Role:
```bash
terraform import -var-file=secrets.tfvars keycloak_role.client_role master/<client-id>/<role-name>
```

#### Identity Providerのインポート

```bash
terraform import -var-file=secrets.tfvars keycloak_oidc_identity_provider.google master/<provider-alias>
```

### インポート後の検証

インポート後、必ず以下のコマンドで差分を確認してください:

```bash
terraform plan -var-file=secrets.tfvars
```

差分がある場合は、各.tfファイルを調整して、実際のKeycloak設定と一致させます。

## 🔧 運用

### 変更の適用

```bash
# 変更内容のプレビュー
terraform plan -var-file=secrets.tfvars

# 変更の適用
terraform apply -var-file=secrets.tfvars
```

### リソースの追加

1. 対応する.tfファイル (clients.tf, users.tf等) にリソース定義を追加
2. `terraform plan`で確認
3. `terraform apply`で適用

### State確認

```bash
# 管理中のリソース一覧
terraform state list

# 特定リソースの詳細
terraform state show keycloak_realm.master
```

## 📚 リファレンス

### 使用しているProvider

- [mrparkers/keycloak](https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs) v4.4.0

### よく使うリソース

- [keycloak_realm](https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/realm)
- [keycloak_openid_client](https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/openid_client)
- [keycloak_user](https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/user)
- [keycloak_group](https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/group)
- [keycloak_role](https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/role)
- [keycloak_oidc_identity_provider](https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/oidc_identity_provider)

## ⚠️ 注意事項

### 管理対象リソース

このTerraform設定では、以下のリソースを管理します:

- Master realmの基本設定
- カスタム作成したClient
- カスタム作成したUser/Group
- カスタム作成したRole
- 設定済みのIdentity Provider

以下のリソースは**管理対象外**です (Keycloakのデフォルト設定として維持):

- adminユーザー
- ビルトインのClient (account, admin-cli, broker等)
- デフォルトのRole (offline_access, uma_authorization等)

### セキュリティ

- `secrets.tfvars` はGit管理対象外です (.gitignoreに含む)
- Client secretやパスワードは環境変数や外部Vault等での管理を検討してください
- Terraform state fileには機密情報が含まれるため、適切に保護してください

### バックアップ

変更を適用する前に、必ずKeycloakのバックアップを取得してください:

```bash
# Keycloak exportコマンドの例 (Keycloakサーバー上で実行)
/opt/keycloak/bin/kc.sh export --dir /tmp/keycloak-backup --realm master
```

## 🤝 貢献

このプロジェクトはProxmox上のKeycloak環境専用です。変更を加える際は、必ず開発環境でテストしてください。

## 📝 ライセンス

社内利用のため、ライセンス情報は適宜設定してください。
