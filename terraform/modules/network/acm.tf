# 東京リージョンの証明書を作成
resource "aws_acm_certificate" "tokyo_cert" {
  domain_name       = "${var.domain_prefix_alb}.${var.domain_name}"
  validation_method = "DNS"

  tags = {
    Environment = var.environment
  }
}

resource "aws_acm_certificate_validation" "cert_validation_tokyo" {
  certificate_arn         = aws_acm_certificate.tokyo_cert.arn
  validation_record_fqdns = [aws_route53_record.validation_tokyo[aws_acm_certificate.tokyo_cert.domain_name].fqdn]
}

# バージニア北部リージョンの証明書を作成(※providerでバージニアの指定を忘れずに！！！)
resource "aws_acm_certificate" "virginia_cert" {
  provider          = aws.useast1
  domain_name       = "${var.domain_prefix_cloudfront}.${var.domain_name}"
  validation_method = "DNS"

  tags = {
    Environment = var.environment
  }
}

resource "aws_acm_certificate_validation" "cert_validation_virginia" {
  provider                = aws.useast1
  certificate_arn         = aws_acm_certificate.virginia_cert.arn
  validation_record_fqdns = [aws_route53_record.validation_virginia[aws_acm_certificate.virginia_cert.domain_name].fqdn]
}
