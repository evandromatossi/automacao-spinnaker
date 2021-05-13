terraform {
  required_providers {
    spinnaker = {
      source = "tidal-engineering/spinnaker"
      version = "1.0.6"
    }
  }
}

provider "spinnaker" {
    server = "var.name_endpoint"
}

## Create app in spinnaker
resource "spinnaker_application" "app" {
    application = "var.name_app"
    email       = "var.name_email"
}

## Pipeline deploy-sit
resource "spinnaker_pipeline" "spinnaker_pipeline_sit" {
    application = spinnaker_application.app.application
    name        = "Deploy-sit"
    pipeline    = file("create-pipeline-deploy-sit.json")
}

## Pipeline deploy-hlg
resource "spinnaker_pipeline" "spinnaker_pipeline_hlg" {
    application = spinnaker_application.app.application
    name        = "Deploy-hlg"
    pipeline    = file("create-pipeline-deploy-hlg.json")
}

## Pipeline deploy-prd
resource "spinnaker_pipeline" "spinnaker_pipeline_prd" {
    application = spinnaker_application.app.application
    name        = "Deploy-prd"
    pipeline    = file("create-pipeline-deploy-prd.json")
}

## Pipeline rollback-prd
resource "spinnaker_pipeline" "spinnaker_pipeline_rollback" {
    application = spinnaker_application.app.application
    name        = "Rollback-prd"
    pipeline    = file("create-pipeline-deploy-rollback.json")
}
