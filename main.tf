
/* Write code for multiple cases:
- use of cloudwatch logs only
- use of s3 logs only
- use of both logs 
*/


# below code is for cloudwatch only

resource "aws_codebuild_project" "build" {
  name          = "${var.project_name}"
  description   = "${var.description}"
  build_timeout = "${var.build_timeout}"
  service_role  = "${var.codebuild_role}"

  artifacts {
    type = "${var.artifacts_type}"
  }

  environment {
    compute_type                = "${var.env_compute_type}"
    image                       = "${var.env_image}"
    type                        = "${var.env_type}"
    image_pull_credentials_type = "${var.env_image_pc_type}"

    #environment_variable {
    #  name  = "${var.var1_name}"
    #  value = "${var.var1_value}"
    #}

    #environment_variable {
    #  name  = "${var.var2_name}"
    #  value = "${var.var2_value}"
    #  type  = "${var.var2_type}"
    #}
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.log_group}"
      stream_name = "${var.log_stream}"
    }

  }

  source {
    type            = "${var.source_type}"
    location        = "${var.source_location}"
    buildspec       = "${var.buildspec_file}"
  }

  source_version = "${var.source_version}"

  vpc_config {
    vpc_id              = "${var.vpc_id}"
    subnets             = "${var.subnet_ids}"
    security_group_ids  = "${var.security_group_ids}"
  }

  tags = {
    Environment = "${var.env_tag}"
  }
}

