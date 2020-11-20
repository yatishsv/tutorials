### Installation in EC2

```
sudo yum update -y
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install vault
vault
```
### Starting the Server

#### Dev Mode

1. Start Dev server and copy Unseal Key and Root Token somewhere
    ```
    vault server -dev
    ```
1. Basics
    1. Launch new terminal session
    1. Configure the Vault client to talk to the dev server.
    1. Set the VAULT_TOKEN environment variable value to the generated Root Token   value (way to provide the token to Vault via CLI so that `vault login` is not     required to authenticate)
    1. Verify that server is running
1. Operations
    1. Write a kv secret (key/value)
    1. Get the written secret
    1. Get a certain field from the written secret
    1. Get the written secret in json format
    1. Delete a secret
1. Secrets Engine
    1. Enabling `kv` secrets engine (already kv plugin installed)
    1. Writing and getting secret in `kv` secrets engine(not `secret` secret engine)
    1. Listing Keys of the secret
    1. Disabling `kv` secrets engine (When a secrets engine is disabled, all    secrets are revoked and the corresponding Vault data and configuration is  removed.
    )
    1. Enabling aws secrets engine
    1. aws secret engine help
1. Token Authentication
    1. Creating a new token
    1. Login with created token
    1. Revoking the token
    1. Login with Root token exported to Environment variable
    1. Enable the GitHub auth method.
    1. GitHub organization maintains a list of users which you are allowing to  authenticate with Vault
    1. Teams may also need access to specific secrets within Vault.
    1. Display all the authentication methods that Vault has enabled.
    1. github auth method help
    1. login with the github auth method
    1. Revoke all tokens generated the github auth method.
    1. Display the github auth method.
1. Policies : Create custom policies (Only read access, write access, secret folder access etc and attach to users(Tokens))
    1. Attach policies to Auth Methods

```
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN="s.Zam1x4EFPmPiFuJn9U1FQRAW"
vault status

vault kv put secret/github username=yatishsv email=yatish.sv@pocketfm.in password=githubpassword
vault kv get secret/github
vault kv get -field=email secret/github
yum install jq -y
vault kv get -format=json secret/github |jq
vault kv delete secret/github

vault secrets enable -path=kv kv
vault kv put kv/github/yatish username=yatishsv email=yatish.sv@pocketfm.in password=githubpassword
vault kv list kv/github/yatish
vault secrets disable kv/
vault secrets enable -path=aws aws
vault path-help aws

vault token create
vault login s.iyNUhq8Ov4hIAx6snw5mB2nL
vault token revoke s.iyNUhq8Ov4hIAx6snw5mB2nL
vault login $VAULT_TOKEN
vault auth enable github
vault write auth/github/config organization=pockefm
vault write auth/github/map/teams/engineering value=default,applications
vault auth list
vault auth help github
vault login -method=github
vault token revoke -mode path auth/github
vault auth disable github
```

#### Prduction Mode

1. Starting up the production server
    1. create `config.hcl` file in working directory
        ```
        storage "raft" {
          path    = "./vault/data"
          node_id = "node1"
        }

        listener "tcp" {
          address     = "127.0.0.1:8200"
          tls_disable = 1
        }

        #disable_mlock = true (disable only if erroring)

        api_addr = "http://127.0.0.1:8200"
        cluster_addr = "https://127.0.0.1:8201"
        ui = true
        ```  
    1. Create `/vault/data` directory that raft storage backend uses
    1. Start vault server
    1. Initialize vault operator to get 5 unseal keys and Token. The process of     teaching Vault how to decrypt the data is known as unsealing the Vault.
    1. Begin unsealing the Vault (3 times, same command, use different keys.    Intended to be unsealed by 3 different operators from 3 different systems)
    1. Authenticate as the initial root token and login
    1. Vault resealing (lets a single operator lock down the Vault in an emergency  without consulting other operators.) When the Vault is sealed again, it clears   all of its state (including the encryption key) from memory. The Vault is     secure and locked down from access.
1. Accessing Secrets via the REST APIs
1. 
1. 
1. 

```
mkdir -p vault/data
vault server -config=config.hcl
vault operator init
vault operator unseal
vault login 
vault operator seal
```