output "instance_id" {
  description = "ID of the demo EC2 instance."
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "Public IP address of the demo EC2 instance."
  value       = aws_instance.web.public_ip
}

output "website_url" {
  description = "HTTP URL for the demo web page."
  value       = "http://${aws_instance.web.public_dns}"
}
