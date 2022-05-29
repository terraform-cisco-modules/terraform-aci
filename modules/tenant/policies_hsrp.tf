resource "aci_hsrp_group_policy" "example" {

  tenant_dn              = aci_tenant.example.id
  name                   = "example"
  annotation             = "example"
  description            = "from terraform"
  ctrl                   = "preempt"
  hello_intvl            = "3000"
  hold_intvl             = "10000"
  key                    = "cisco"
  name_alias             = "example"
  preempt_delay_min      = "60"
  preempt_delay_reload   = "60"
  preempt_delay_sync     = "60"
  prio                   = "100"
  timeout                = "60"
  hsrp_group_policy_type = "md5"

}
# Argument Reference
# tenant_dn - (Required) Distinguished name of parent tenant object.
# name - (Required) Name of Object hsrp group policy.
# annotation - (Optional) Annotation for object hsrp group policy.
# description - (Optional) Description for object hsrp group policy.
# ctrl - (Optional) The control state.
# Allowed values: "preempt", "0". Default value: "0".
# hello_intvl - (Optional) The hello interval. Default value: "3000".
# hold_intvl - (Optional) The period of time before declaring that the neighbor is down. Default value: "10000".
# key - (Optional) The key or password used to uniquely identify this configuration object. If key is set, the object key will reset when terraform configuration is applied. Default value: "cisco".
# name_alias - (Optional) Name name_alias for object hsrp group policy.
# preempt_delay_min - (Optional) HSRP Group's Minimum Preemption delay. Default value: "0".
# preempt_delay_reload - (Optional) Preemption delay after switch reboot. Default value: "0".
# preempt_delay_sync - (Optional) Maximum number of seconds to allow IPredundancy clients to prevent preemption. Default value: "0".
# prio - (Optional) The QoS priority class ID. Default value: "100".
# timeout - (Optional) Amount of time between authentication attempts. Default value: "0".
# hsrp_group_policy_type - (Optional) The specific type of the object or component.
# Allowed values: "md5", "simple". Default value: "simple".

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