data "aws_route53_zone" "default" {
  name = "${var.domain_name}."
}

resource "aws_route53_record" "alb" {
  zone_id = data.aws_route53_zone.default.zone_id
  name    = "${var.domain_prefix_alb}.${var.domain_name}" # 作成したいレコードの名前
  type    = "A"

  #ALBに関連付ける
  alias {
    name                   = aws_lb.alb.dns_name # ここにALBのDNS名を指定
    zone_id                = aws_lb.alb.zone_id  # ここにALBのホストゾーンIDを指定
    evaluate_target_health = true                # ALBのヘルスチェックを有効にする場合はtrue
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
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
