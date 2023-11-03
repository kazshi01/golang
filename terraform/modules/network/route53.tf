data "aws_route53_zone" "default" {
  name = "${var.domain_name}."
}

#ALBのDNS名を指定してAレコードを作成
resource "aws_route53_record" "alb" {
  zone_id = data.aws_route53_zone.default.zone_id
  name    = "${var.domain_prefix_alb}.${var.domain_name}" # 作成したいレコードの名前
  type    = "A"
  alias {
    name                   = aws_lb.alb.dns_name # ここにALBのDNS名を指定
    zone_id                = aws_lb.alb.zone_id  # ここにALBのホストゾーンIDを指定
    evaluate_target_health = true                # ALBのヘルスチェックを有効にする場合はtrue
  }
}

#CloudFrontのDNS名を指定してAレコードを作成
resource "aws_route53_record" "cloudfront" {
  zone_id = data.aws_route53_zone.default.zone_id
  name    = "${var.domain_prefix_cloudfront}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.server_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.server_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}

# 東京リージョンのACM証明書のDNS検証用のレコード
resource "aws_route53_record" "validation_tokyo" {
  for_each = {
    for dvo in aws_acm_certificate.tokyo_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.default.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 30
}

# バージニア北部のACM証明書のDNS検証用のレコード
resource "aws_route53_record" "validation_virginia" {
  for_each = {
    for dvo in aws_acm_certificate.virginia_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.default.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 30
}
