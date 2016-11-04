provider "aws" {
  region = "${var.aws_region}"
  #shared_credentials_file = "${var.credentials_file}"
  #profile = "${var.credentials_profile}"
}
