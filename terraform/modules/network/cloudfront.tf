resource "aws_cloudfront_distribution" "server_distribution" {
  # CloudFrontのオリジン設定をALBのDNS名に変更
  # depends_on = [aws_acm_certificate_validation.cert_validation_virginia]

  origin {
    domain_name = "${var.domain_prefix_alb}.${var.domain_name}"
    origin_id   = "myALBOrigin"

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "https-only" # HTTPを使用する場合は "http-only" もしくは "match-viewer" を選択。
      origin_ssl_protocols     = ["TLSv1.2"]
      origin_keepalive_timeout = 5
      origin_read_timeout      = 30
    }
  }

  enabled             = true
  comment             = "CloudFront distribution for ALB"
  default_root_object = ""

  # CloudFrontのログ設定
  # logging_config {
  #   include_cookies = false
  #   bucket          = "バケット名"
  #   prefix          = "cloudfront_log"
  # }

  # CNAMEs（カスタムドメイン名）
  aliases = ["${var.domain_prefix_cloudfront}.${var.domain_name}"]

  # デフォルトキャッシュ動作の設定
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "myALBOrigin"

    #静的コンテンツの場合
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    #動的コンテンツの場合
    # forwarded_values {
    #   query_string = true # クエリ文字列をオリジンに転送し、キャッシュの決定に使用

    #   cookies {
    #     forward = "all" # または "whitelist" と特定のクッキー名
    #     ※"all"は、すべてのクッキーを転送することを意味するので、セキュリティ上の理由から推奨されない。
    #     # クッキーが必要な場合は、セッションIDや認証トークンなど特定のクッキーをホワイトリストに登録する
    #     whitelisted_names = ["sessionid", "auth-token"]
    #   }
    # }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 60
    default_ttl            = 60
    max_ttl                = 60
  }

  # 地理的制限の設定
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["JP"] # 日本からのアクセスのみを許可
    }
  }

  # ビューア証明書の設定
  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.virginia_cert.arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2019"
    cloudfront_default_certificate = false
  }

  # CloudFront配信設定のタグ
  tags = {
    Environment = var.environment
  }
}
