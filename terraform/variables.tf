variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-north-1"
}

# Free tier:
# In your first year includes 750 hours of t2.micro (or t3.micro in the Regions in which t2.micro is unavailable)
# instance usage on free tier AMIs per month, 750 hours of public IPv4 address usage per month, 30 GiB of EBS storage,
# 2 million IOs, 1 GB of snapshots, and 100 GB of bandwidth to the internet.

variable "instance_type" {
  description = "Instance type that meets your computing, memory, networking, or storage needs"
  type        = string
  default     = "t3.micro" # vCPUs=2 Architecture=x86_64 Memory=1GiB NetworkPerformance=5 Gigabit
}

variable "ami_id" {
  description = "Amazon Machine Image (AMI) ID that contains the software configuration (operating system (OS), application server, and applications) required to launch your instance"
  type        = string
  default     = "ami-05edb7c94b324f73c" # Amazon Linux 2023 in eu-north-1
}

variable "instance_name" {
  description = "Name for instance"
  type        = string
  default     = "ShipIt"
}
