
# resource "azurerm_policy_assignment" "allowed_locations" {
#   name                 = "only-allowed-locations"
#   scope                = var.scope
#   policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/allowed-locations"
#
#   parameters = jsonencode({
#     listOfAllowedLocations = {
#       value = ["eastus", "eastus2"]
#     }
#   })
# }
