
variable "tenants" {
  default = {
    "default" = {
      alias             = ""
      annotation        = ""
      annotations       = []
      controller_type   = "apic" # apic or ndo
      description       = ""
      monitoring_policy = ""
      global_alias      = ""
      sites             = []
      users             = []
    }
  }
  description = <<-EOT
  Key: Name of the Tenant.
  * alias: A changeable name for a given object. While the name of an object, once created, can't be changed, the Alias is a field that can be changed.
  * annotation: A search keyword or term that is assigned to the Object. Annotations allow you to group multiple objects by descriptive names. You can assign the same annotation name to multiple objects and you can assign one or more annotation names to a single object.
  * annotations: A key/value pair of annotations to assign to an object.
  * controller_type: What is the type of controller.  Options are:
    - apic: For APIC Controllers
    - ndo: For Nexus Dashboard Orchestrator
  * description: Description to add to the Object.  The description can be up to 128 alphanumeric characters.
  * global_alias: A changeable name for a given object. While the name of an object, once created, cannot be changed, the name_alias is a field that can be changed.
  * sites: When using Nexus Dashboard Orchestrator the sites attribute is used to distinguish the site and cloud types.  Options are:
    - aws_access_key_id: (Optional) - AWS Access Key Id. It must be provided if the AWS account is not trusted. This parameter will only have effect with vendor = aws.
    - aws_account_id: (Optional) - Id of AWS account. It's required when vendor is set to aws. This parameter will only have effect with vendor = aws
    - azure_access_type: (Optional) - Type of Azure Account Configuration. Allowed values are managed, shared and credentials. Default to managed. Other Credentials are not required if azure_access_type is set to managed. This parameter will only have effect with vendor = azure.
      * credentials
      * managed
      * shared
    - azure_active_directory_id: (Optional) - Azure Active Directory Id. It must be provided when azure_access_type to credentials. This parameter will only have effect with vendor = azure.
    - azure_application_id: (Optional) - Azure Application Id. It must be provided when azure_access_type to credentials. This parameter will only have effect with vendor = azure.
    - azure_shared_account_id: (Optional) - Azure shared account Id. It must be provided when azure_access_type to shared. This parameter will only have effect with vendor = azure.
    - azure_subscription_id: (Optional) - Azure subscription id. It's required when vendor is set to azure. This parameter will only have effect with vendor = azure.
    - is_aws_account_trusted: (Optional) - Azure Access Key ID.
    - site: (Required) - Name of the Site to Associate
    - vendor: The type of vendor to apply the tenant to.
      * aws
      * azure
      * cisco
  EOT
  type = map(object(
    {
      alias      = optional(string)
      annotation = optional(string)
      annotations = optional(list(object(
        {
          key   = string
          value = string
        }
      )))
      controller_type   = optional(string)
      description       = optional(string)
      global_alias      = optional(string)
      monitoring_policy = optional(string)
      sites = optional(list(object(
        {
          aws_access_key_id         = optional(string)
          aws_account_id            = optional(string)
          azure_access_type         = optional(string)
          azure_active_directory_id = optional(string)
          azure_application_id      = optional(string)
          azure_shared_account_id   = optional(string)
          azure_subscription_id     = optional(string)
          is_aws_account_trusted    = optional(string)
          site                      = string
          vendor                    = optional(string)
        }
      )))
      users = optional(list(string))
    }
  ))
}

variable "aws_secret_key" {
  default     = ""
  description = "AWS Secret Key Id. It must be provided if the AWS account is not trusted. This parameter will only have effect with vendor = aws."
  sensitive   = true
  type        = string
}

variable "azure_client_secret" {
  default     = "1"
  description = "Azure Client Secret. It must be provided when azure_access_type to credentials. This parameter will only have effect with vendor = azure."
  sensitive   = true
  type        = string
}

/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "fvTenant"
 - Distinguished Name: "uni/tn-{tenant}""
GUI Location:
 - Tenants > Create Tenant > {tenant}
_______________________________________________________________________________________________________________________
*/
resource "aci_tenant" "tenants" {
  for_each = { for k, v in local.tenants : k => v if v.controller_type == "apic" }
  # annotation                    = each.value.annotation != "" ? each.value.annotation : var.annotation
  # description                   = each.value.description
  name                          = each.key
  name_alias                    = each.value.alias
  relation_fv_rs_tenant_mon_pol = each.value.monitoring_policy != "" ? "uni/tn-common/monepg-${each.value.monitoring_policy}" : ""
}

resource "mso_tenant" "tenants" {
  provider = mso
  depends_on = [
    data.mso_site.sites,
    data.mso_user.users
  ]
  for_each     = { for k, v in local.tenants : k => v if v.controller_type == "ndo" }
  name         = each.key
  display_name = each.key
  dynamic "site_associations" {
    for_each = { for k, v in each.value.sites : k => v if v.vendor == "aws" }
    content {
      aws_access_key_id = length(regexall(
        "aws", site_associations.value.vendor)
      ) > 0 ? site_associations.value.aws_access_key_id : ""
      aws_account_id = length(regexall(
        "aws", site_associations.value.vendor)
      ) > 0 ? site_associations.value.aws_account_id : ""
      aws_secret_key = length(regexall(
        "aws", site_associations.value.vendor)
      ) > 0 ? var.aws_secret_key : ""
      site_id = data.mso_site.sites[site_associations.value.site].id
      vendor  = site_associations.value.vendor
    }
  }
  dynamic "site_associations" {
    for_each = { for k, v in each.value.sites : k => v if v.vendor == "azure" }
    content {
      azure_access_type = length(regexall(
        "azure", site_associations.value.vendor)
      ) > 0 ? site_associations.value.azure_access_type : ""
      azure_active_directory_id = length(regexall(
        "azure", site_associations.value.vendor)
      ) > 0 && site_associations.value.azure_access_type == "credentials" ? site_associations.value.azure_active_directory_id : ""
      azure_application_id = length(regexall(
        "azure", site_associations.value.vendor)
      ) > 0 && site_associations.value.azure_access_type == "credentials" ? site_associations.value.azure_application_id : ""
      azure_client_secret = length(regexall(
        "azure", site_associations.value.vendor)
      ) > 0 && site_associations.value.azure_access_type == "credentials" ? var.azure_client_secret : ""
      azure_shared_account_id = length(regexall(
        "azure", site_associations.value.vendor)
      ) > 0 && site_associations.value.azure_access_type == "shared" ? site_associations.value.azure_shared_account_id : ""
      azure_subscription_id = length(regexall(
        "azure", site_associations.value.vendor)
      ) > 0 ? site_associations.value.azure_subscription_id : ""
      site_id = data.mso_site.sites[site_associations.value.site].id
      vendor  = site_associations.value.vendor
    }
  }
  dynamic "site_associations" {
    for_each = { for k, v in each.value.sites : k => v if v.vendor == "cisco" }
    content {
      site_id = data.mso_site.sites[site_associations.value.site].id
    }
  }
  dynamic "user_associations" {
    for_each = toset(each.value.users)
    content {
      user_id = data.mso_user.users[user_associations.value].id
    }
  }
}
