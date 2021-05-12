terraform {
  required_providers {
    spinnaker = {
      source = "tidal-engineering/spinnaker"
      version = "1.0.6"
    }
  }
}

provider "spinnaker" {
    server = "https://spinnaker-api.viavarejo.com.br"
}

## Create app in spinnaker
resource "spinnaker_application" "terraform_example" {
    application = "automacaoterraform"
    email       = "evandro.junior@viavarejo.com.br"
}

## Pipeline deploy-sit
resource "spinnaker_pipeline" "terraform_example" {
    application = spinnaker_application.terraform_example.application
    name        = "Deploy-sit"
    pipeline    = file("create-pipeline-deploy.json")
}

## Pipeline deploy-hlg
resource "spinnaker_pipeline" "terraform_example_01" {
    application = spinnaker_application.terraform_example.application
    name        = "Deploy-hlg"
    pipeline    = file("create-pipeline-deploy.json")
}

## Pipeline deploy-prd
resource "spinnaker_pipeline" "terraform_example_02" {
    application = spinnaker_application.terraform_example.application
    name        = "Deploy-prd"
    pipeline    = file("create-pipeline-deploy.json")
}

## Pipeline rollback-prd
resource "spinnaker_pipeline" "terraform_example_03" {
    application = spinnaker_application.terraform_example.application
    name        = "Rollback-prd"
    pipeline    = file("create-pipeline-deploy.json")
}
