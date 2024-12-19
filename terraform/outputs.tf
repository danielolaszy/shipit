output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.shipit.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.shipit.public_ip
}

# Output the VPC ID and Subnet ID for reference
output "vpc_id" {
  value = aws_vpc.shipit_vpc.id
}

output "subnet_id" {
  value = aws_subnet.shipit_subnet.id
}

output "security_group_id" {
  value = aws_security_group.shipit_security_group.id
}