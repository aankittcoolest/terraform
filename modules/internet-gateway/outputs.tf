output "internet_gateway_id" {
    description = "The ID of the gateway"
    value = try(aws_internet_gateway.gw.id, "")
}