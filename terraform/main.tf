data "aws_iam_policy_document" "read_bucket" {
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:GetBucketVersioning",
      "s3:GetAccelerateConfiguration",
      "s3:ListBucket",
      "s3:ListBucketVersions",
      "s3:ListBucketMultipartUploads",
    ]

    resources = [
      "${var.cross_account_bucket_arn}",
    ]

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "read_object" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectACL",
      "s3:GetObjectTagging",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
      "s3:ListMultipartUploadParts",
    ]

    resources = [
      "${var.cross_account_bucket_arn}/*",
    ]

    effect = "Allow"
  }
}

resource "aws_iam_policy" "iam_policy_read_bucket" {
  name   = "cross-account-s3-bucket-read"
  policy = "${data.aws_iam_policy_document.read_bucket.json}"
}

resource "aws_iam_policy" "iam_policy_read_object" {
  name   = "cross-account-s3object-read"
  policy = "${data.aws_iam_policy_document.read_object.json}"
}

resource "aws_iam_role_policy_attachment" "policy_attachment_bucket_read" {
  role       = "${var.role_name}"
  policy_arn = "${aws_iam_policy.iam_policy_read_bucket.arn}"
}

resource "aws_iam_role_policy_attachment" "policy_attachment_object_read" {
  role       = "${var.role_name}"
  policy_arn = "${aws_iam_policy.iam_policy_read_object.arn}"
}
