locals{
    CachingDisabled = data.aws_cloudfront_cache_policy.CachingDisabled.id 
    CachingOptimized = data.aws_cloudfront_cache_policy.CachingOptimized.id
    common_name = "${var.project}-${var.env}"

  common_tags = {
    project   = var.project
    env       = var.env
    terraform = true
  }
}