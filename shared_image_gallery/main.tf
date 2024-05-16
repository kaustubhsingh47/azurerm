resource "azurerm_shared_image_gallery" "sig" {

  name                = ${module.naming-convention.short_resource.azurerm_shared_image_gallery}-${var.short_location}-${var.short_env}-${var.ait}-${var.short_name}

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  description         = "Shared image gallery for App L2"

  sharing {
    permission = "Private"
  }
}

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


resource "azurerm_shared_image" "si" {
  name                = ${module.naming-convention.short_resource.azurerm_shared_image_gallery}-${var.short_location}-${var.short_env}-${var.ait}-${var.short_name}
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = var.os_type

  identifier {
    publisher = "PublisherName"
    offer     = "OfferName"
    sku       = "ExampleSku"
  }

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


resource "azurerm_shared_image_version" "example" {
  name                = "0.0.1"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  image_name          = azurerm_shared_image.si.name
  resource_group_name = azurerm_shared_image.rg.resource_group_name
  location            = azurerm_shared_image.rg.location
  managed_image_id    = azurerm_image.si.azurerm_shared_image.id

  target_region {
    name                   = azurerm_shared_image.si.location
    regional_replica_count = 5
    storage_account_type   = "Standard_LRS"
  }
}
