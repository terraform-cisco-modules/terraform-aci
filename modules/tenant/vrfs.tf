/*_____________________________________________________________________________________________________________________

Tenant — VRFs
_______________________________________________________________________________________________________________________
*/
variable "vrfs" {
  default = {
    "default" = {
      alias                           = ""
      annotation                      = ""
      annotations                     = []
      bd_enforcement_status           = false
      bgp_timers                      = "default"
      bgp_timers_per_address_family   = []
      communities                     = []
      controller_type                 = "apic"
      description                     = ""
      eigrp_timers_per_address_family = []
      endpoint_retention_policy       = "default"
      epg_esg_collection_for_vrfs = [
        {
          contracts            = []
          label_match_criteria = "AtleastOne"
        }
      ]
      global_alias                          = ""
      ip_data_plane_learning                = "enabled"
      layer3_multicast                      = true
      monitoring_policy                     = ""
      ospf_timers                           = "default"
      ospf_timers_per_address_family        = []
      policy_control_enforcement_direction  = "ingress"  # "egress"
      policy_control_enforcement_preference = "enforced" # unenforced
      preferred_group                       = false
      sites                                 = []
      template                              = ""
      transit_route_tag_policy              = ""
      /*  If undefined the variable of local.first_tenant will be used for:
      policy_source_tenant           = local.first_tenant
      schema                         = local.first_tenant
      tenant                         = local.first_tenant
      */
    }
  }
  description = <<-EOT
    Key — Name of the VRF/Context.
    * controller_type: (optional) — The type of controller.  Options are:
      - apic: (default)
      - ndo
    SHARED (APIC & NDO) Attributes:
    * description: (optional) — Description to add to the Object.  The description can be up to 128 characters.
    * epg_esg_collection_for_vrfs: (optional) — VzAny Contract List of Objects to assign to the VRF.
      - contracts: (optional) — List of Contracts and Attributes to assign to the EPG|ESG Collection for a VRF. aka VzAny.
        * name: (required) — The Name of the contract to assign.
        * qos_class: (optional) — The priority class identifier. Allowed values are:
          - level1
          - level2
          - level3
          - level4
          - level5
          - level6
          - unspecified: (default)
        * schema: (optional) — The Name of the Schema that contains the contract for controller_type: ndo.
        * template: (optional) — The Name of the Template that contains the contract for controller_type: ndo.
        * tenant: (default: VRF Tenant) — The Name of the tenant the contract was created in.
        * contract_type: (required) — The type of contract to be assigned.  Options are:
          - consumed
          - contract_interface
          - provided
      - label_match_criteria: (optional) — Represents the provider label match criteria. The options are:
        * All
        * AtleastOne: (default)
        * AtmostOne
        * None
    * ip_data_plane_learning: (default: enabled) — Defines if IP addresses are learned through dataplane packets for the VRF.  When disabled, IP addresses are not learned from the dataplane. Local and remote MAC addresses are still learned, but local IP addresses are not. Remote IP addresses are not learned from unicast packets but are learned from multicast packets.  Note:  Regardless if this parameter is enabled or disabled, local IP addresses can still be learned from ARP, GARP, and ND. 
    * layer3_multicast: (optional) — Flag to enable or disable Layer 3 Multicast in the VRF.
      - false: (default)
      - true
    * policy_control_enforcement_preference: (optional) — Should Contracts be enforced or unenforced within the VRF. The policy enforcement can be:
      - enforced: (default) — Security rules (contracts) will be enforced.
      - unenforced — Security rules (contracts) will not be enforced.
    * preferred_group: (optional) — Enable the Preferred Group feature to allow preferred group members in the VRF to communicate with each other without requiring a contract between them.
      - false: (default) — Contracts are required for EPGs in the VRF to communicate with each other.
      - true — For EPGs that are preferred group members in the VRF, contracts are not required to communicate with each other.
    * tenant: (default: local.tenant) — The Name of the Tenant to create the VRF within.
    APIC Specific Attributes:
    * alias: (optional) — The Name Alias feature (or simply "Alias" where the setting appears in the GUI) changes the displayed name of objects in the APIC GUI. While the underlying object name cannot be changed, the administrator can override the displayed name by entering the desired name in the Alias field of the object properties menu. In the GUI, the alias name then appears along with the actual object name in parentheses, as name_alias (object_name).
    * annotation: (optional) — An annotation will mark an Object in the GUI with a small blue circle, signifying that it has been modified by  an external source/tool.  Like Nexus Dashboard Orchestrator or in this instance Terraform.
    * annotations: (optional) — You can add arbitrary key:value pairs of metadata to an object as annotations (tagAnnotation). Annotations are provided for the user's custom purposes, such as descriptions, markers for personal scripting or API calls, or flags for monitoring tools or orchestration applications such as Cisco Multi-Site Orchestrator (MSO). Because APIC ignores these annotations and merely stores them with other object data, there are no format or content restrictions imposed by APIC.
    * bd_enforcement_status: (optional) — Set the BD Enforcement Status to “true” to enable this condition: Only allow endpoints to ping their bridge domain gateways.  Ping from hosts on different bridge domains cannot ping other gateways.  You can then create a global exception list of IP addresses which can ping any subnet gateway.
      - false: default
      - true
    * bgp_timers: (default: default) — Assign a BGP Timers policies to the VRF. 
    * bgp_timers_per_address_family: (optional) — Assign a BGP Timers policy for the VRF to the IPv4 and IPv6 Address Families.  “fvRsCtxToBgpCtxAfPol” is the API Class Name.
      - address_family: (optional) — Options are:
        * ipv4: (default)
        * ipv6
      - policy: (required) — Name of the BGP Timers Policy to assign to the Address Family.
    * communities: (optional) — A list of Communities to Assign to the VRF.  This Section is only necessary if you want a "SNMP Context Community" Defined. Note: a Community can only be used within the context (VRF) when assigned to it.  But a Fabric Wide SNMP Community can be used for an SNMP Context when qualified with the Context.
          community_variable: (required) — A value between 1 to 5 that will point to the snmp_community_{value} variable.
          description: (optional) — Description to add to the Object.  The description can be up to 128 characters.
    * eigrp_timers_per_address_family: (optional) — Assign an EIGRP Timers policy for the VRF to the IPv4 and IPv6 Address Families.  “fvRsCtxToEigrpCtxAfPol” is the API Class Name.
      - address_family: (optional) — Options are:
        * ipv4: (default)
        * ipv6
      - policy: (required) — Name of the EIGRP Timers Policy to assign to the Address Family.
    * endpoint_retention_policy: (default: default) — Name of the Endpoint Retention Policy to assign to the VRF.
    * global_alias: (optional) — The Global Alias feature simplifies querying a specific object in the API. When querying an object, you must specify a unique object identifier, which is typically the object's DN. As an alternative, this feature allows you to assign to an object a label that is unique within the fabric.
    * monitoring_policy: (default: default) — To keep it simple the monitoring policy must be in the common Tenant.
    * ospf_timers: (default: default) — Assign an OSPF timers policies to the VRF.  “ospfCtxPol” is the API Class Name.
    * ospf_timers_per_address_family: (optional) — Assign an OSPF Timers policy for the VRF to the IPv4 and IPv6 Address Families.  “ospfCtxPol” is the API Class Name.
      - address_family: (optional) — Options are:
        * ipv4: (default)
        * ipv6
      - policy: (required) — Name of the OSPF Timers Policy to assign to the Address Family.
    * policy_source_tenant: (default: local.first_tenant) — Name of the tenant that contains the policies to assign to the VRF.
    * policy_control_enforcement_direction: (optional) — Defines the policy enforcement direction coming to or from a Layer 3 Outside connection (L3Out). The direction can be:
      - ingress: (default) — Policy is enforced on ingress traffic.
      - egress — Policy is enforced on egress traffic.
    * transit_route_tag_policy       = ""
    Nexus Dashboard Orchestrator Specific Attributes:
    * schema: (required) — Schema Name.
    * sites: (optional) — List of Site Names to assign site specific attributes.
    * template: (required) — The Template name to create the object within.
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
      bd_enforcement_status = optional(bool)
      bgp_timers            = optional(string)
      bgp_timers_per_address_family = optional(list(object(
        {
          address_family = optional(string)
          policy         = string
        }
      )))
      communities = optional(list(object(
        {
          community_variable = number
          description        = optional(string)
        }
      )))
      controller_type = optional(string)
      description     = optional(string)
      eigrp_timers_per_address_family = optional(list(object(
        {
          address_family = optional(string)
          policy         = string
        }
      )))
      endpoint_retention_policy = optional(string)
      epg_esg_collection_for_vrfs = optional(list(object(
        {
          contracts = optional(list(object(
            {
              contract_type = string
              name          = string
              qos_class     = optional(string)
              schema        = optional(string)
              template      = optional(string)
              tenant        = optional(string)
            }
          )))
          label_match_criteria = optional(string)
        }
      )))
      global_alias           = optional(string)
      ip_data_plane_learning = optional(string)
      layer3_multicast       = optional(bool)
      monitoring_policy      = optional(string)
      ospf_timers            = optional(string)
      ospf_timers_per_address_family = optional(list(object(
        {
          address_family = optional(string)
          policy         = string
        }
      )))
      policy_source_tenant                  = optional(string)
      policy_control_enforcement_direction  = optional(string)
      policy_control_enforcement_preference = optional(string)
      preferred_group                       = optional(bool)
      schema                                = optional(string)
      sites                                 = optional(list(string))
      template                              = optional(string)
      tenant                                = optional(string)
      transit_route_tag_policy              = optional(string)
    }
  ))
}

variable "vrf_snmp_community_1" {
  default     = ""
  description = "SNMP Community 1."
  sensitive   = true
  type        = string
}

variable "vrf_snmp_community_2" {
  default     = ""
  description = "SNMP Community 2."
  sensitive   = true
  type        = string
}

variable "vrf_snmp_community_3" {
  default     = ""
  description = "SNMP Community 3."
  sensitive   = true
  type        = string
}

variable "vrf_snmp_community_4" {
  default     = ""
  description = "SNMP Community 4."
  sensitive   = true
  type        = string
}

variable "vrf_snmp_community_5" {
  default     = ""
  description = "SNMP Community 5."
  sensitive   = true
  type        = string
}


/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "fvCtx"
 - Distinguished Name: "uni/tn-{tenant}/ctx-{vrf}"
GUI Location:
 - Tenants > {tenant} > Networking > VRFs > {vrf}
_______________________________________________________________________________________________________________________
*/
resource "aci_vrf" "vrfs" {
  depends_on = [
    aci_tenant.tenants
  ]
  for_each = { for k, v in local.vrfs : k => v if v.controller_type == "apic" }
  # annotation             = each.value.annotation != "" ? each.value.annotation : var.annotation
  bd_enforced_enable     = each.value.bd_enforcement_status == true ? "yes" : "no"
  description            = each.value.description
  ip_data_plane_learning = each.value.ip_data_plane_learning
  knw_mcast_act          = each.value.layer3_multicast == true ? "permit" : "deny"
  name                   = each.key
  name_alias             = each.value.alias
  pc_enf_dir             = each.value.policy_control_enforcement_direction
  pc_enf_pref            = each.value.policy_control_enforcement_preference
  # relation_fv_rs_ctx_to_ep_ret = length(regexall(
  #   "[[:alnum:]]", each.value.endpoint_retention_policy)
  # ) > 0 ? aci_end_point_retention_policy.endpoint_retention_policies[each.value.endpoint_retention_policy].id : ""
  relation_fv_rs_ctx_mon_pol = length(regexall(
    "uni\\/tn\\-", each.value.monitoring_policy)
    ) > 0 ? each.value.monitoring_policy : length(regexall(
    "[[:alnum:]]", each.value.monitoring_policy)
  ) > 0 ? "uni/tn-${each.value.policy_source_tenant}/monepg-${each.value.monitoring_policy}" : ""
  relation_fv_rs_bgp_ctx_pol = length(regexall(
    "uni\\/tn\\-", each.value.bgp_timers)
    ) > 0 ? each.value.bgp_timers : length(regexall(
    "[[:alnum:]]", each.value.bgp_timers)
  ) > 0 ? "uni/tn-${each.value.policy_source_tenant}/bgpCtxP-${each.value.bgp_timers}" : ""
  dynamic "relation_fv_rs_ctx_to_bgp_ctx_af_pol" {
    for_each = each.value.bgp_timers_per_address_family
    content {
      af = "${relation_fv_rs_ctx_to_bgp_ctx_af_pol.value.address_family}-ucast"
      tn_bgp_ctx_af_pol_name = length(regexall(
        "uni\\/tn\\-", relation_fv_rs_ctx_to_bgp_ctx_af_pol.value.policy)
        ) > 0 ? relation_fv_rs_ctx_to_bgp_ctx_af_pol.value.policy : length(regexall(
        "[[:alnum:]]", relation_fv_rs_ctx_to_bgp_ctx_af_pol.value.policy)
      ) > 0 ? "uni/tn-${each.value.policy_source_tenant}/bgpCtxAfP-${relation_fv_rs_ctx_to_bgp_ctx_af_pol.value.policy}" : ""
    }
  }
  dynamic "relation_fv_rs_ctx_to_eigrp_ctx_af_pol" {
    for_each = each.value.eigrp_timers_per_address_family
    content {
      af = "${relation_fv_rs_ctx_to_eigrp_ctx_af_pol.value.address_family}-ucast"
      tn_eigrp_ctx_af_pol_name = length(regexall(
        "uni\\/tn\\-", relation_fv_rs_ctx_to_eigrp_ctx_af_pol.value.policy)
        ) > 0 ? relation_fv_rs_ctx_to_eigrp_ctx_af_pol.value.policy : length(regexall(
        "[[:alnum:]]", relation_fv_rs_ctx_to_eigrp_ctx_af_pol.value.policy)
      ) > 0 ? "uni/tn-${each.value.policy_source_tenant}/eigrpCtxAfP-${relation_fv_rs_ctx_to_eigrp_ctx_af_pol.value.policy}" : ""
    }
  }
  relation_fv_rs_ospf_ctx_pol = length(regexall(
    "uni\\/tn\\-", each.value.ospf_timers)
    ) > 0 ? each.value.ospf_timers : length(regexall(
    "[[:alnum:]]", each.value.ospf_timers)
  ) > 0 ? "uni/tn-${each.value.policy_source_tenant}/ospfCtxP-${each.value.ospf_timers}" : ""
  dynamic "relation_fv_rs_ctx_to_ospf_ctx_pol" {
    for_each = each.value.ospf_timers_per_address_family
    content {
      af = "${relation_fv_rs_ctx_to_ospf_ctx_pol.value.address_family}-ucast"
      tn_ospf_ctx_pol_name = length(regexall(
        "uni\\/tn\\-", relation_fv_rs_ctx_to_ospf_ctx_pol.value.policy)
        ) > 0 ? relation_fv_rs_ctx_to_ospf_ctx_pol.value.policy : length(regexall(
        "[[:alnum:]]", relation_fv_rs_ctx_to_ospf_ctx_pol.value.policy)
      ) > 0 ? "uni/tn-${each.value.policy_source_tenant}/ospfCtxP-${relation_fv_rs_ctx_to_ospf_ctx_pol.value.policy}" : ""
    }
  }
  relation_fv_rs_ctx_to_ext_route_tag_pol = length(regexall(
    "uni\\/tn\\-", each.value.transit_route_tag_policy)
    ) > 0 ? each.value.transit_route_tag_policy : length(regexall(
    "[[:alnum:]]", each.value.transit_route_tag_policy)
  ) > 0 ? "uni/tn-${each.value.policy_source_tenant}/rttag-${each.value.transit_route_tag_policy}" : ""
  # relation_fv_rs_ctx_mcast_to             = ["{vzFilter}"]
  tenant_dn = aci_tenant.tenants[each.value.tenant].id
}

resource "mso_schema_template_vrf" "vrfs" {
  provider = mso
  depends_on = [
    aci_tenant.tenants,
    mso_schema.schemas
  ]
  for_each         = { for k, v in local.vrfs : k => v if v.controller_type == "ndo" }
  schema_id        = mso_schema.schemas[each.value.schema].id
  template         = each.value.template
  name             = each.key
  display_name     = each.key
  layer3_multicast = each.value.layer3_multicast
  vzany            = length(each.value.epg_esg_collection_for_vrfs[0].contracts) > 0 ? true : false
}

resource "mso_schema_site_vrf" "vrfs" {
  provider = mso
  depends_on = [
    aci_tenant.tenants,
    mso_schema.schemas
  ]
  for_each      = { for k, v in local.vrf_sites : k => v if v.controller_type == "ndo" }
  schema_id     = mso_schema.schemas[each.value.schema].id
  site_id       = data.mso_site.ndo_sites[each.value.site].id
  template_name = each.value.template
  vrf_name      = each.value.vrf
}

/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "snmpCtxP"
 - Distinguished Name: "uni/tn-{tenant}/ctx-{vrf}/snmpctx"
GUI Location:
 - Tenants > {tenant} > Networking > VRFs > {vrf} > Create SNMP Context
_______________________________________________________________________________________________________________________
*/
resource "aci_vrf_snmp_context" "vrf_snmp_contexts" {
  depends_on = [
    aci_vrf.vrfs
  ]
  for_each   = { for k, v in local.vrfs : k => v if v.controller_type == "apic" }
  annotation = each.value.annotation != "" ? each.value.annotation : var.annotation
  name       = each.key
  vrf_dn     = aci_vrf.vrfs[each.key].id
}


/*_____________________________________________________________________________________________________________________

GUI Location:
Tenants > {tenant} > Networking > VRFs > {vrf} > Create SNMP Context: Community Profiles
_______________________________________________________________________________________________________________________
*/
resource "aci_snmp_community" "vrf_communities" {
  depends_on = [
    aci_vrf_snmp_context.vrf_snmp_contexts
  ]
  for_each    = local.vrf_communities
  annotation  = each.value.annotation != "" ? each.value.annotation : var.annotation
  description = each.value.description
  name = length(regexall(
    5, each.value.community_variable)) > 0 ? var.vrf_snmp_community_5 : length(regexall(
    4, each.value.community_variable)) > 0 ? var.vrf_snmp_community_4 : length(regexall(
    3, each.value.community_variable)) > 0 ? var.vrf_snmp_community_3 : length(regexall(
  2, each.value.community_variable)) > 0 ? var.vrf_snmp_community_2 : var.vrf_snmp_community_1
  parent_dn = aci_vrf_snmp_context.vrf_snmp_contexts[each.value.vrf].id
}
/*_____________________________________________________________________________________________________________________

GUI Location:
 - Tenants > {tenant} > Networking > VRFs > {vrf} > EPG Collection for VRF: [Provided/Consumed Contracts]
_______________________________________________________________________________________________________________________
*/
resource "aci_rest_managed" "vzany_provider_contracts" {
  for_each   = { for k, v in local.vzany_contracts : k => v if v.controller_type == "apic" && v.contract_type == "provided" }
  dn         = "uni/tn-${each.value.tenant}/ctx-${each.value.vrf}/any/rsanyToProv-${each.value.contract}"
  class_name = "vzRsAnyToProv"
  content = {
    # annotation   = each.value.annotation != "" ? each.value.annotation : var.annotation
    matchT       = each.value.label_match_criteria
    prio         = each.value.qos_class
    tnVzBrCPName = each.value.contract
  }
}

resource "aci_rest_managed" "vzany_contracts" {
  for_each = { for k, v in local.vzany_contracts : k => v if v.controller_type == "apic" && v.contract_type != "provided" }
  dn = length(regexall(
    "consumed", each.value.contract_type)
    ) > 0 ? "uni/tn-${each.value.tenant}/ctx-${each.value.vrf}/any/rsanyToCons-${each.value.contract}" : length(regexall(
    "interface", each.value.contract_type)
  ) > 0 ? "uni/tn-${each.value.tenant}/ctx-${each.value.vrf}/any/rsanyToConsif-${each.value.contract}" : ""
  class_name = length(regexall(
    "consumed", each.value.contract_type)
    ) > 0 ? "vzRsAnyToCons" : length(regexall(
    "interface", each.value.contract_type)
  ) > 0 ? "vzRsAnyToConsIf" : ""
  content = {
    # annotation   = each.value.annotation != "" ? each.value.annotation : var.annotation
    prio         = each.value.qos_class
    tnVzBrCPName = each.value.contract
  }
}

resource "mso_schema_template_vrf_contract" "vzany_contracts" {
  depends_on = [
    mso_schema_template_vrf.vrfs
  ]
  for_each          = { for k, v in local.vzany_contracts : k => v if v.controller_type == "ndo" }
  schema_id         = mso_schema.schemas[each.value.schema].id
  template_name     = each.value.template
  vrf_name          = each.value.vrf
  relationship_type = each.value.contract_type
  contract_name     = each.value.contract
  contract_schema_id = length(regexall(
    each.value.tenant, each.value.contract_tenant)
    ) > 0 ? mso_schema.schemas[each.value.contract_schema].id : length(regexall(
    "[[:alnum:]]+", each.value.contract_tenant)
  ) > 0 ? data.mso_schema.schemas[each.value.contract_schema].id : ""
  contract_template_name = each.value.contract_template
}

/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "snmpCtxP"
 - Distinguished Name: "uni/tn-{tenant}/ctx-{vrf}/any"
GUI Location:
 - Tenants > {tenant} > Networking > VRFs > {vrf}: Policy >  Preferred Group
 - Tenants > {tenant} > Networking > VRFs > {vrf} > EPG|ESG Collection for VRF
_______________________________________________________________________________________________________________________
*/
resource "aci_any" "vz_any" {
  depends_on = [
    aci_vrf.vrfs
  ]
  for_each     = { for k, v in local.vrfs : k => v if v.controller_type == "apic" }
  annotation   = each.value.annotation != "" ? each.value.annotation : var.annotation
  description  = each.value.description
  pref_gr_memb = each.value.preferred_group == true ? "enabled" : "disabled"
  match_t      = each.value.epg_esg_collection_for_vrfs[0].label_match_criteria
  vrf_dn       = aci_vrf.vrfs[each.key].id
}

/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "tagAnnotation"
 - Distinguished Name: "uni/tn-{tenant}/ctx-{vrf}/annotationKey-[{key}]"
GUI Location:
 - Tenants > {tenant} > Networking > VRFs > {vrf}: {annotations}
_______________________________________________________________________________________________________________________
*/
resource "aci_rest_managed" "vrfs_annotations" {
  depends_on = [
    aci_vrf.vrfs
  ]
  for_each   = local.vrfs_annotations
  dn         = "uni/tn-${each.value.tenant}/ctx-${each.value.vrf}/annotationKey-[${each.value.key}]"
  class_name = "tagAnnotation"
  content = {
    key   = each.value.key
    value = each.value.value
  }
}

/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "tagAliasInst"
 - Distinguished Name: "uni/tn-{tenant}/ctx-{vrf}/alias"
GUI Location:
 - Tenants > {tenant} > Networking > VRFs > {vrf}: global_alias

_______________________________________________________________________________________________________________________
*/
resource "aci_rest_managed" "vrfs_global_alias" {
  depends_on = [
    aci_vrf.vrfs
  ]
  for_each   = local.vrfs_global_alias
  class_name = "tagAliasInst"
  dn         = "uni/tn-${each.value.tenant}/ctx-${each.value.vrf}/alias"
  content = {
    name = each.value.global_alias
  }
}
