provider "local" {}

terraform {
    # Config passada via terraform init
    backend "s3" { }
}