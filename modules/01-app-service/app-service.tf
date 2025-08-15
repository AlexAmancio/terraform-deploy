resource "azurerm_service_plan" "linux_free_plan" {
  name                = "app-${local.naming_convention}-linux-free-plansss"
  location            = var.region_zone
  resource_group_name = var.rg_name

  os_type  = "Linux" # 🚀 Más eficiente que Windows
  sku_name = "F1"    # 🆓 FREE - Sin costo

  tags = {
    Environment = "Free"
    Cost        = "Zero"
    OS          = "Linux"
    Tier        = "F1"
  }
}

# Linux Web App GRATUITO con .NET 8
resource "azurerm_linux_web_app" "linux_free_app" {
  name                = "helloworld-${local.naming_convention}-appsss"
  location            = var.region_zone
  resource_group_name = var.rg_name
  service_plan_id     = azurerm_service_plan.linux_free_plan.id

  site_config {
    # .NET 8 en Linux - Sintaxis correcta
    application_stack {
      dotnet_version = "8.0" # Sin 'v' para Linux
    }

    # 🚨 CONFIGURACIONES CRÍTICAS PARA F1
    always_on         = false # OBLIGATORIO en F1
    use_32_bit_worker = true  # F1 solo soporta 32-bit

    # Configuraciones básicas permitidas
    ftps_state          = "FtpsOnly"
    http2_enabled       = true
    minimum_tls_version = "1.2"
  }

  # Variables de entorno optimizadas para producción gratuita
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"        = "1"
    "ASPNETCORE_ENVIRONMENT"          = "Production"
    "WEBSITE_ENABLE_SYNC_UPDATE_SITE" = "true"

    # Optimizaciones para .NET en Linux
    "DOTNET_USE_POLLING_FILE_WATCHER"            = "true"
    "ASPNETCORE_LOGGING__CONSOLE__DISABLECOLORS" = "true"

    # Configuración de timezone (opcional)
    "WEBSITE_TIME_ZONE" = "UTC"
  }

  # Configuración de logs de aplicación (simplificada)
  logs {
    application_logs {
      file_system_level = "Information"
    }

    http_logs {
      file_system {
        retention_in_days = 1  # Mínimo para F1
        retention_in_mb   = 25 # Reducido para F1
      }
    }
  }

  tags = {
    Environment = "Free"
    Cost        = "Zero"
    OS          = "Linux"
    Framework   = "DotNet8"
    Tier        = "F1"
  }
}
