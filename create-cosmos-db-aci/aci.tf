resource "azurerm_container_group" "main" {
  name                = "${random_pet.rg_name.id}-vote-aci"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = "vote-aci-${random_integer.ri.result}"
  os_type             = "Linux"

#     image_registry_credential {
#     server   = "myregistry.azurecr.io"
#     username = "myregistry"
#     password = "myregistrypassword"
#   }

  container {
    name   = "vote-aci-back"
    # image  = "mcr.microsoft.com/azuredocs/azure-vote-front:cosmosdb"
    image  = "mcr.microsoft.com/azuredocs/azure-vote-front"
    # image  = "hub.docker.com/repository/docker/lgmorand/azure-vote-front:v1"
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port     = 80
      protocol = "TCP"
    }

    secure_environment_variables = {
      "COSMOS_DB_ENDPOINT"  = azurerm_cosmosdb_account.vote_cosmos_db.endpoint
      "COSMOS_DB_MASTERKEY" = azurerm_cosmosdb_account.vote_cosmos_db.primary_key
      "TITLE"               = "Azure Voting App"
      "VOTE1VALUE"          = "Cats"
      "VOTE2VALUE"          = "Dogs"
    }
  }
}