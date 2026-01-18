variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}

variable "internal" {
  description = "Whether the ALB is internal"
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for ALB"
  type        = bool
  default     = false
}

variable "enable_http2" {
  description = "Enable HTTP/2 for ALB"
  type        = bool
  default     = true
}

variable "enable_cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  type        = bool
  default     = true
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle"
  type        = number
  default     = 60
}

variable "enable_access_logs" {
  description = "Enable access logs"
  type        = bool
  default     = false
}

variable "access_logs_bucket" {
  description = "S3 bucket name for access logs"
  type        = string
  default     = ""
}

variable "access_logs_prefix" {
  description = "S3 bucket prefix for access logs"
  type        = string
  default     = ""
}

variable "allow_cidr_blocks" {
  description = "CIDR blocks allowed to access the ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol for the target group"
  type        = string
  default     = "HTTP"
}

variable "target_type" {
  description = "Type of target (instance, ip, lambda)"
  type        = string
  default     = "ip"
}

variable "health_check_enabled" {
  description = "Enable health check"
  type        = bool
  default     = true
}

variable "health_check_healthy_threshold" {
  description = "Number of consecutive health checks successes before marking healthy"
  type        = number
  default     = 2
}

variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive health check failures before marking unhealthy"
  type        = number
  default     = 2
}

variable "health_check_timeout" {
  description = "Timeout for health check"
  type        = number
  default     = 5
}

variable "health_check_interval" {
  description = "Interval between health checks"
  type        = number
  default     = 30
}

variable "health_check_path" {
  description = "Path for health check"
  type        = string
  default     = "/"
}

variable "health_check_protocol" {
  description = "Protocol for health check"
  type        = string
  default     = "HTTP"
}

variable "health_check_matcher" {
  description = "HTTP codes to use when checking for a healthy target"
  type        = string
  default     = "200"
}

variable "deregistration_delay" {
  description = "Amount of time for connections to drain"
  type        = number
  default     = 300
}

variable "slow_start" {
  description = "Amount of time for targets to warm up before the load balancer sends them a full share of requests"
  type        = number
  default     = 0
}

variable "stickiness_enabled" {
  description = "Enable stickiness"
  type        = bool
  default     = false
}

variable "stickiness_type" {
  description = "Type of stickiness (lb_cookie, app_cookie)"
  type        = string
  default     = "lb_cookie"
}

variable "stickiness_cookie_duration" {
  description = "Cookie duration for stickiness"
  type        = number
  default     = 86400
}

variable "create_http_listener" {
  description = "Create HTTP listener"
  type        = bool
  default     = true
}

variable "create_https_listener" {
  description = "Create HTTPS listener"
  type        = bool
  default     = false
}

variable "http_listener_redirect_to_https" {
  description = "Redirect HTTP to HTTPS"
  type        = bool
  default     = false
}

variable "ssl_policy" {
  description = "SSL policy for HTTPS listener"
  type        = string
  default     = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
