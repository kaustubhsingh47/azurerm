resource "azurerm_shared_image_gallery" "sig" {

  name                = ${module.naming-convention.short_resource.azurerm_image_gallery}-${var.short_location}-${var.short_env}-${var.ait}-${var.short_name}

  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  description         = "Shared image gallery for App L2"

  tags                         = local.tags
  
   lifecycle {
    ignore_changes = [
      tags["CreatedDate"],
      tags["Environment"],
      tags["AIT"],
      tags["CostCenter"],
      tags["RunID"],
      ]
  }
}
