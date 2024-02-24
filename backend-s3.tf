terraform {
  backend "s3" {
    bucket = "awsstateterraform"
    key = "terra-state/backend"
    region = "us-west-1"
  }
}
