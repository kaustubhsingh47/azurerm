resource "azurerm_shared_image_gallery" "sig" {

  name                = ${module.naming-convention.short_resource.azurerm_shared_image_gallery}-${var.short_location}-${var.short_env}-${var.ait}-${var.short_name}

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  description         = "Shared image gallery for App L2"

  sharing {
    permission = "Private"
  }

  softDeletePolicy {
    isSoftDeleteEnabled = true
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
    publisher = var.indentifier_publisher
    offer     = var.indentifier_offer
    sku       = var.indentifier_sku
  }

  disk_types_not_allowed = var.disk_types_not_allowed
  hyper_v_generation     = var.hyper_v_generation
  end_of_life_date       = "${timeadd(timestamp(), "17520h")}"
  eula                   = var.eula
  specialized            = var.specialized

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


resource "azurerm_shared_image_version" "siv" {
  name                = "0.0.1"
  gallery_name        = azurerm_shared_image_gallery.sig.name
  image_name          = azurerm_shared_image.si.name
  resource_group_name = azurerm_shared_image.rg.resource_group_name
  location            = azurerm_shared_image.rg.location
  managed_image_id    = azurerm_image.si.id

  target_region {
    name                         = azurerm_shared_image.si.location
    regional_replica_count       = var.regional_replica_count
    storage_account_type         = var.storage_account_type
    disk_encryption_set_id       = var.disk_encryption_set_id
    exclude_from_latest_enabled  = var.exclude_from_latest_enabled
  }

  end_of_life_date         = formatdate("YYYY-MM-DD", timeadd(timestamp(), "15d"))



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
