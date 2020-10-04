terraform {
    backend "remote" {
    hostname      = "app.terraform.io"
    organization  = "thebrokenloop"

    workspaces {
      name = "state-migration"
    }
  }
}