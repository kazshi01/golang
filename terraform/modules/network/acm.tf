resource "aws_acm_certificate" "cert" {
  domain_name       = "${var.domain_prefix_alb}.${var.domain_name}"
  validation_method = "DNS"

  tags = {
    Environment = var.environment
  }
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.validation[aws_acm_certificate.cert.domain_name].fqdn]
}
