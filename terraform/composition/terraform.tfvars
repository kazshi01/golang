name                       = "terraform"
region                     = "ap-northeast-1"
public                     = true
vpc_cidr                   = "10.0.0.0/16"
db_name                    = "example"
db_username                = "example"
skip_final_snapshot        = true
environment                = "dev"
internal                   = false
enable_deletion_protection = false
domain_name                = "example.com"
domain_prefix_alb          = "alb"
domain_prefix_cloudfront   = "cloudfront"
s3_bucket_name             = "example-buket"
frontend_bucket_name       = "react-app"
container_name             = "go"
hostPort                   = 8080
containerPort              = 8080
assign_public_ip           = true
ecr_name                   = "dev/practice"
image_tag                  = "go-14e841d40ad27dbf5d82a933d75e7f8b1fe9987b"
