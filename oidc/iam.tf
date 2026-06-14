resource "aws_iam_role" "github_actions" {
  name = "github-actions-role"

  assume_role_policy = data.aws_iam_policy_document.github_assume_role.json
}

data "aws_iam_policy_document" "github_assume_role" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"

      identifiers = [
        aws_iam_openid_connect_provider.github.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringLike"

      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:${var.github_org}/${var.github_repo}:*"
      ]
    }
  }
}


resource "aws_iam_role_policy_attachment" "admin" {
  role       = aws_iam_role.github_actions.name

  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}