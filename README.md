# infra-terraform-actions

Projeto template de CI de infra com terraform via GithubActions.

Ao realizar commit/PR para a branch `main` a esteira será inicializada:
![](workflow.png)
1. AWS
    Irá realizar a configuração do aws-cli com o access_key e secret_key armazenados como secret no actions.
2. Terraform
    - Terraform init
        Install do provider
    - Terraform formt
        Formatação do código
    - Terraform plan
        Criação de plano de execução
    - Terraform apply
        Aplica o plano