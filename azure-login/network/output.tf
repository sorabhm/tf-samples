
output "tf_subneta_id" {
  value = azurerm_subnet.tf_subnet_a.id
}
output "tf_subnetb_id" {
  value = azurerm_subnet.tf_subnet_b.id
}
output "tf_peer_subneta_id" {
  value = azurerm_subnet.tf_peer_subnet_a.id
}
output "tf_peer_subnetb_id" {
  value = azurerm_subnet.tf_peer_subnet_b.id
}