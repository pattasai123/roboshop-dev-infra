resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name              = "${var.project}-${var.env}.${var.domain_name}"
    origin_access_control_id = "${var.project}-${var.env}.${var.domain_name}"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only" # S3 website endpoints do not support HTTPS directly
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true

  aliases = ["${var.env}.${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.project}-${var.env}.${var.domain_name}"

    viewer_protocol_policy = "https-only"
    cache_policy_id = local.CachingDisabled
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/image/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${var.project}-${var.env}.${var.domain_name}"

    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id = local.CachingOptimized
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/media/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.project}-${var.env}.${var.domain_name}"

    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id = local.CachingOptimized
  }
  price_class = "PriceClass_All"
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["IN"]
    }
  }

  tags = merge(
    var.cloudfront_tags,
    local.common_tags,
    {
      Name = "${local.common_name}-cloudfront"
    }
  )

  viewer_certificate {
    acm_certificate_arn = data.aws_ssm_parameter.frontend_alb_arn.value
    ssl_support_method  = "sni-only"
  }
}

data "aws_route53_zone" "53" {
  name = var.domain_name
}

resource "aws_route53_record" "cloudfront" {
  for_each = aws_cloudfront_distribution.main.aliases
  zone_id  = data.aws_route53_zone.zone.zone_id
  name     = each.value
  type     = "A"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}