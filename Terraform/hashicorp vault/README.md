# Hashicorp Vault And Terraform intergration

## Vault Starting commands

### Start dev server

```
vault server -dev
```

### Set env values

```
set VAULT_ADDR=http://127.0.0.1:8200

set VAULT_TOKEN=<Root Token>
```

### Get vault server status

```
vault status
```

### key/value operations

```
vault kv put -mount=secret db_creds root=admin

vault kv get -mount=secret db_creds

vault kv delete -mount=secret db_creds
```
