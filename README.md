# infra-terraform-actions

Projeto template de CI de infra com terraform via GithubActions.

## Projeto
1. `providers.tf` é configurado o backend para salvar o tfstate em um bucket s3. A configuração do backend é passada via `terraform init` no job do Terraform.
1. `main.tf` criação dos recursos de infra.

## Pipeline
Ao realizar commit/PR para a branch `main` a esteira será inicializada:

![](workflow.png)

1. AWS
    Irá realizar a configuração do aws-cli com o access_key e secret_key armazenados como secret no actions.
2. Terraform
    - Terraform init
        Install do provider e configuração do backend.
    - Terraform formt
        Formatação do código.
    - Terraform plan
        Criação de plano de execução.
    - Terraform apply
        Aplica o plano.

## TODO list
1. Criar role na AWS
    - Definir permissoes minimas para executar a esteira.
    - Definir um external-id para a role.

1. Setar as variaveis de ambiente `EXTERNAL_ID` e `ROLE_ARN` no Github Actions:
    ```bash
    EXTERNAL_ID=ExternalIdName
    ROLE_ARN=arn:aws:iam::ID:role/RoleName
    ```
1. Executar assume-role no job de aws no workflows/terraform.yaml
    ```bash
        aws sts assume-role \
        --role-arn ${{ env.ROLE_ARN }} \
        --external-id ${{ env.EXTERNAL_ID }} \
        --role-session-name terraform-session \
        --duration-second 900 \
        --query "{aws_access_key_id: Credentials.AccessKeyId, aws_secret_access_key:Credentials.SecretAccessKey, aws_session_token:Credentials.SessionToken}"
    ```

1. Setar credenciais geradas como variaveis de ambiente.
    - No job de `Terraform`, pegar as credenciais geradas no passo anterior para criar a infra.