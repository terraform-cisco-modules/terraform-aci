resource "aci_hsrp_interface_policy" "example" {
  tenant_dn    = aci_tenant.tenentcheck.id
  name         = "one"
  annotation   = "example"
  description  = "from terraform"
  ctrl         = "bia,bfd"
  delay        = "10"
  name_alias   = "example"
  reload_delay = "10"
}
# Argument Reference
# tenant_dn - (Required) Distinguished name of parent tenant object.
# name - (Required) Name of HSRP interface policy object.
# annotation - (Optional) Annotation for HSRP interface policy object.
# description - (Optional) Description for HSRP interface policy object.
# ctrl - (Optional) Control state for HSRP interface policy object. It is in the form of comma separated string and allowed values are "bia" and "bfd". To deselect both the options, just pass ctrl="". Default value is "" that means none of the options are selected.
# delay - (Optional) Administrative port delay for HSRP interface policy object.Range: "0" to "10000". Default value is "0".
# name_alias - (Optional) Name name_alias for HSRP interface policy object.
# reload_delay - (Optional) Reload delay for HSRP interface policy object.Range: "0" to "10000". Default value is "0".