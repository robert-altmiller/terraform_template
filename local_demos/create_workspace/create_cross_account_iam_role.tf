data "databricks_aws_assume_role_policy" "this" {
  external_id = local.vars.dbricks.conn.account_id
}

resource "aws_iam_role" "cross_account_role" {
  name               = local.vars.aws.iam.role_name
  assume_role_policy = data.databricks_aws_assume_role_policy.this.json
  tags               = local.vars.aws.iam.role_tags
}

data "databricks_aws_crossaccount_policy" "this" {
}

resource "aws_iam_role_policy" "this" {
  name   = local.vars.aws.iam.role_policy_name
  role   = aws_iam_role.cross_account_role.id
  policy = data.databricks_aws_crossaccount_policy.this.json
}

resource "databricks_mws_credentials" "this" {
  depends_on = [aws_iam_role_policy.this, time_sleep.wait_10_seconds]
  provider         = databricks.mws
  account_id       = local.vars.dbricks.conn.account_id
  role_arn         = aws_iam_role.cross_account_role.arn
  credentials_name = local.vars.dbricks.ws.mws_credentials_name
}

resource "time_sleep" "wait_10_seconds" {
  # Wait for 10 seconds
  create_duration = "10s"
}