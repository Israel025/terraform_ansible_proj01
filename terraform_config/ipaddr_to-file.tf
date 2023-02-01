#==================================
# Save the ip address of the instances to a file
locals {
  ip_addrs = [for server in aws_instance.web_servers : server.public_ip]
}

resource "local_file" "Ip_address" {
  filename = var.local-file_path
  content  = <<EOT
[webservers]
${local.ip_addrs[0]}
${local.ip_addrs[1]}
${local.ip_addrs[2]}
  EOT
}