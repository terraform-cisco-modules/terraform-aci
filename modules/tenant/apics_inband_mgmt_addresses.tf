/*_____________________________________________________________________________________________________________________

APIC Inband Management Addresses — Variables
_______________________________________________________________________________________________________________________
*/
variable "apics_inband_mgmt_addresses" {
  default     = {}
  description = <<-EOT
    key - Node ID of the APIC
    * ipv4_address: (optional) — IPv4 Address/Prefix of the Inband Management EPG.
    * ipv4_gateway: (optional) — IPv4 Gateway of the Inband Management EPG.
    * ipv6_address: (optional) — IPv6 Address/Prefix of the Inband Management EPG.
    * ipv6_gateway: (optional) — IPv6 Gateway of the Inband Management EPG.
    * management_epg: (required) — Name of the Inband Management EPG.
    * pod_id: (required) — Identifier of the pod where the node is located.  Unless you are configuring Multi-Pod, this should always be 1.
  EOT
  type = map(object(
    {
      ipv4_address   = optional(string)
      ipv4_gateway   = optional(string)
      ipv6_address   = optional(string)
      ipv6_gateway   = optional(string)
      management_epg = string
      pod_id         = optional(string)
    }
  ))
}


/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "mgmtRsInBStNode" or "mgmtRsOoBStNode"
 - Distinguished Name: "uni/tn-mgmt/mgmtp-default/inb-{management_epg}/rsinBStNode-[topology/pod-{pod_id}/node-{node_id}]"
 or
 - Distinguished Name: "uni/tn-mgmt/mgmtp-default/oob-{management_epg}/rsooBStNode-[topology/pod-{pod_id}/node-{node_id}]"
GUI Location:
 - Tenants > mgmt > Node Management Addresses > Static Node Management Addresses
_______________________________________________________________________________________________________________________
*/
resource "aci_static_node_mgmt_address" "apics_inband_mgmt_addresses" {
  depends_on = [
    aci_application_epg.application_epgs
  ]
  for_each          = var.apics_inband_mgmt_addresses
  management_epg_dn = "uni/tn-mgmt/mgmtp-default/inb-${each.value.management_epg}"
  t_dn = length(compact([each.value.pod_id])
  ) > 0 ? "topology/pod-${each.value.pod_id}/node-${each.key}" : "topology/pod-1/node-${each.key}"
  type       = "in_band"
  annotation = var.annotation
  addr = length(compact([each.value.ipv4_address])
  ) > 0 ? each.value.ipv4_address : ""
  gw = length(compact([each.value.ipv4_gateway])
  ) > 0 ? each.value.ipv4_gateway : ""
  v6_addr = length(compact([each.value.ipv6_address])
  ) > 0 ? each.value.ipv6_address : ""
  v6_gw = length(compact([each.value.ipv6_gateway])
  ) > 0 ? each.value.ipv6_gateway : ""
}