resource "aws_cloudfront_distribution" "server_distribution" {
  # CloudFrontのオリジンにS3を指定
  origin {
    domain_name = "react-app-marukome.s3-website-ap-northeast-1.amazonaws.com"
    origin_id   = "myS3origin"

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "http-only"
      origin_ssl_protocols     = ["TLSv1.2"]
      origin_keepalive_timeout = 5
      origin_read_timeout      = 30
    }
  }

  enabled             = true
  comment             = "CloudFront distribution for S3"
  default_root_object = "index.html"

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
    target_origin_id = "myS3origin"

    # forward設定(all: 全てのヘッダーを転送) 
    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }

    # より細かいフォーワード設定
    # forwarded_values {
    #   query_string = true
    #   cookies {
    #     forward           = "whitelist"
    #     whitelisted_names = ["_csrf", "token"] # CSRFとJWTトークンが含まれるCookie名
    #   }
    #   headers = ["Origin", "Access-Control-Request-Headers", "Access-Control-Request-Method", "X-CSRF-Token"]
    # }

    viewer_protocol_policy = "redirect-to-https"
    default_ttl            = 0
    max_ttl                = 0
    min_ttl                = 0
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
