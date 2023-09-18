data "aws_iam_policy_document" "assume_codepipeline_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "tf-codepipeline-role" {
  name = "tf-codepipeline-role"
  path = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_codepipeline_role.json
}
data "aws_iam_policy_document" "tf-cicd-pipeline-policies" {

    statement{
        sid = ""
        actions = ["cloudwatch:*", "s3:*","codecommit:*", "codebuild:*"]
        resources = ["*"]
        effect = "Allow"
    }
}
resource "aws_iam_policy" "tf-cicd-pipeline-policy" {
    name = "tf-cicd-pipeline-policy"
    path = "/"
    description = "Pipeline policy"
    policy = data.aws_iam_policy_document.tf-cicd-pipeline-policies.json
}

resource "aws_iam_role_policy_attachment" "tf-cicd-pipeline-attachment" {
    policy_arn = aws_iam_policy.tf-cicd-pipeline-policy.arn
    role = aws_iam_role.tf-codepipeline-role.id
}
data "aws_iam_policy_document" "assume_codebuild_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole",]
  }
}
# data "aws_iam_policy_document" "assume_codebuild_role_codecommit" {
#   statement {
#     sid = "AllowPullSourceCodeFromCodeCommit"
#     effect = "Allow"
#     resources = ["*"]
#     principals {
#       type        = "Service"
#       identifiers = ["codebuild.amazonaws.com"]
#     }
#     actions = []
#   }
# }
resource "aws_iam_role" "tf-codebuild-role" {
  name = "tf-codebuild-role"
  assume_role_policy =  data.aws_iam_policy_document.assume_codebuild_role.json
}
data "aws_iam_policy_document" "tf-cicd-build-policies" {
    statement{
        sid = ""
        actions = ["logs:*", "s3:*", "codebuild:*", "secretsmanager:*","iam:*","codecommit:GitPull"]
        resources = ["*"]
        effect = "Allow"
    }
}
resource "aws_iam_policy" "tf-cicd-build-policy" {
    name = "tf-cicd-build-policy"
    path = "/"
    description = "Codebuild policy"
    policy = data.aws_iam_policy_document.tf-cicd-build-policies.json
}
resource "aws_iam_role_policy_attachment" "tf-cicd-codebuild-attachment1" {
    policy_arn  = aws_iam_policy.tf-cicd-build-policy.arn
    role        = aws_iam_role.tf-codebuild-role.id
}
resource "aws_iam_role_policy_attachment" "tf-cicd-codebuild-attachment2" {
    policy_arn  = "arn:aws:iam::aws:policy/PowerUserAccess"
    role        = aws_iam_role.tf-codebuild-role.id
}