/*_____________________________________________________________________________________________________________________

L3Out - Variables
_______________________________________________________________________________________________________________________
*/
variable "l3outs" {
  default = {
    "default" = {
      alias           = ""
      annotation      = ""
      annotations     = []
      controller_type = "apic"
      description     = ""
      enable_bgp      = false
      external_epgs = [
        {
          alias                  = ""
          contract_exception_tag = 0
          contracts              = []
          /* Example Contract
          contracts = [
            {
              name          = "default"
              contract_type = "consumed" # consumed|interface|intra_epg|provided|taboo
              qos_class     = "unspecified"
              schema        = ""
              template      = ""
              tenant        = local.first_tenant
            }
          ]
          */
          description            = ""
          epg_type               = "default" # default or oob
          flood_on_encapsulation = "disabled"
          match_type             = "AtleastOne"
          name                   = "default"
          preferred_group_member = false
          qos_class              = "unspecified"
          subnets = [
            {
              aggregate = [{
                aggregate_export        = false
                aggregate_shared_routes = false
              }]
              description = ""
              external_epg_classification = [{
                external_subnets_for_external_epg = true
                shared_security_import_subnet     = false
              }]
              route_control = [{
                export_route_control_subnet = false
                shared_route_control_subnet = false
              }]
              route_control_profiles = []
              # Example
              # route_control_profiles = [{
              #   direction = "export" # export/import
              #   route_map = "default"
              #   tenant = "**l3out_tenant**"
              # }]
              route_summarization_policy = ""
              subnets                    = ["0.0.0.0/1", "128.0.0.0/1"]
            }
          ]
          route_control_profiles = []
          /* Example
          route_control_profiles = [{
            direction = "export" # export/import
            route_map = "default"
          }]
          */
          target_dscp = "unspecified"
        }
      ]
      l3_domain             = ""
      level                 = "template"
      ospf_external_profile = []
      /* Example
      ospf_external_profile = [
        {
          ospf_area_cost = 1
          ospf_area_control = [{
            send_redistribution_lsas_into_nssa_area = true
            originate_summary_lsa                   = true
            suppress_forwarding_address             = false
          }]
          ospf_area_id   = "0.0.0.0"
          ospf_area_type = "regular" # nssa, regular, stub
        }
      ]
      */
      route_control_enforcement = [
        {
          export = true
          import = false
        }
      ]
      route_control_for_dampening = []
      /* Example
      route_control_for_dampening = [
        {
          address_family = "ipv4"
          route_map      = "**REQUIRED**"
        }
      ]
      */
      target_dscp = "unspecified"
      sites       = []
      vrf         = "default"
      /* If undefined the variable of local.first_tenant will be used
      policy_source_tenant = local.first_tenant
      schema               = local.first_tenant
      template             = local.first_tenant
      tenant               = local.first_tenant
      */
    }
  }
  description = <<-EOT
    Key: Name of the VRF.
    * annotation: A search keyword or term that is assigned to the Object. Tags allow you to group multiple objects by descriptive names. You can assign the same tag name to multiple objects and you can assign one or more tag names to a single object.
    * bgp_context_per_address_family: 
    * description: Description to add to the Object.  The description can be up to 128 alphanumeric characters.
    * name_alias: A changeable name for a given object. While the name of an object, once created, cannot be changed, the name_alias is a field that can be changed.
    * type: What is the type of controller.  Options are:
      - apic: For APIC Controllers
      - ndo: For Nexus Dashboard Orchestrator
    * vendor: When using Nexus Dashboard Orchestrator the vendor attribute is used to distinguish the cloud types.  Options are:
      - aws
      - azure
      - cisco (Default)
    # Argument Reference
    # addr: (optional) — Peer address for L3out floating SVI object. Default value: "0.0.0.0".
    # annotation: (optional) — Annotation for L3out floating SVI object.
    # autostate: (optional) — Autostate for L3out floating SVI object. Allowed values are "disabled" and "enabled". Default value is "disabled".
    # description: (optional) — Description for L3out floating SVI object.
    # encap: (required) — Port encapsulation for L3out floating SVI object.
    # encap_scope: (optional) — Encap scope for L3out floating SVI object. Allowed values are "ctx" and "local". Default value is "local".
    # if_inst_t: (optional) — Interface type for L3out floating SVI object. Allowed values are "ext-svi", "l3-port", "sub-interface" and "unspecified". Default value is "unspecified".
    # ipv6_dad: (optional) — IPv6 dad for L3out floating SVI object. Allowed values are "disabled" and "enabled". Default value is "enabled".
    # ll_addr: (optional) — Link local address for L3out floating SVI object. Default value: "::".
    # logical_interface_profile_dn: (required) — Distinguished name of parent logical interface profile object.
    # mac: (optional) — MAC address for L3out floating SVI object.
    # mode: (optional) — BGP domain mode for L3out floating SVI object. Allowed values are "native", "regular" and "untagged". Default value is "regular".
    # mtu: (optional) — Administrative MTU port on the aggregated interface for L3out floating SVI object. Range of allowed values is "576" to "9216". Default value is "inherit".
    # node_dn: (required) — Distinguished name of the node for L3out floating SVI object.
    # relation_l3ext_rs_dyn_path_att: (optional) — Relation to class infraDomP. Cardinality - N_TO_M. Type - Set of String.
    # target_dscp: (optional) — Target DSCP for L3out floating SVI object. Allowed values are "AF11", "AF12", "AF13", "AF21", "AF22", "AF23", "AF31", "AF32", "AF33", "AF41", "AF42", "AF43", "CS0", "CS1", "CS2", "CS3", "CS4", "CS5", "CS6", "CS7", "EF", "VA" and "unspecified". Default value is "unspecified".
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
      controller_type = optional(string)
      description     = optional(string)
      enable_bgp      = optional(bool)
      external_epgs = optional(list(object(
        {
          alias                  = optional(string)
          contract_exception_tag = optional(number)
          contracts = optional(list(object(
            {
              contract_type = optional(string)
              name          = string
              qos_class     = optional(string)
              schema        = optional(string)
              template      = optional(string)
              tenant        = optional(string)
            }
          )))
          description            = optional(string)
          epg_type               = optional(string)
          flood_on_encapsulation = optional(string)
          match_type             = optional(string)
          name                   = string
          preferred_group_member = optional(bool)
          qos_class              = optional(string)
          subnets = list(object(
            {
              aggregate = optional(list(object(
                {
                  aggregate_export        = optional(bool)
                  aggregate_shared_routes = optional(bool)
                }
              )))
              description = optional(string)
              external_epg_classification = optional(list(object(
                {
                  external_subnets_for_external_epg = optional(bool)
                  shared_security_import_subnet     = optional(bool)
                }
              )))
              route_control = optional(list(object(
                {
                  export_route_control_subnet = optional(bool)
                  shared_route_control_subnet = optional(bool)
                }
              )))
              route_control_profiles = optional(list(object(
                {
                  direction = string
                  route_map = string
                }
              )))
              route_summarization_policy = optional(string)
              subnets                    = list(string)
            }
          ))
          route_control_profiles = optional(list(object(
            {
              direction = string
              route_map = string
            }
          )))
          target_dscp = optional(string)
        }
      )))
      l3_domain            = optional(string)
      level                = optional(string)
      policy_source_tenant = optional(string)
      ospf_external_profile = optional(list(object(
        {
          ospf_area_cost = optional(number)
          ospf_area_control = optional(list(object(
            {
              send_redistribution_lsas_into_nssa_area = optional(bool)
              originate_summary_lsa                   = optional(bool)
              suppress_forwarding_address             = optional(bool)
            }
          )))
          ospf_area_id   = optional(string)
          ospf_area_type = optional(string)
        }
      )))
      route_control_enforcement = optional(list(object(
        {
          export = optional(bool)
          import = optional(bool)
        }
      )))
      route_control_for_dampening = optional(list(object(
        {
          address_family = optional(string)
          route_map      = string
          tenant         = optional(string)
        }
      )))
      target_dscp = optional(string)
      sites       = optional(list(string))
      template    = optional(string)
      tenant      = optional(string)
      vrf         = optional(string)
    }
  ))
}



/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "l3extOut"
 - Distinguished Name: "/uni/tn-{tenant}/out-{l3out}"
GUI Location:
 - tenants > {tenant} > Networking > L3Outs > {l3out}
_______________________________________________________________________________________________________________________
*/
resource "aci_l3_outside" "l3outs" {
  depends_on = [
    aci_tenant.tenants,
    aci_vrf.vrfs
  ]
  for_each               = { for k, v in local.l3outs : k => v if v.controller_type == "apic" }
  annotation             = each.value.annotation != "" ? each.value.annotation : var.annotation
  description            = each.value.description
  enforce_rtctrl         = each.value.import == true ? ["export", "import"] : ["export"]
  name                   = each.key
  name_alias             = each.value.alias
  target_dscp            = each.value.target_dscp
  tenant_dn              = aci_tenant.tenants[each.value.tenant].id
  relation_l3ext_rs_ectx = aci_vrf.vrfs[each.value.vrf].id
  relation_l3ext_rs_l3_dom_att = length(regexall(
    "[[:alnum:]]+", each.value.l3_domain)
  ) > 0 ? "uni/l3dom-${each.value.l3_domain}" : ""
  dynamic "relation_l3ext_rs_dampening_pol" {
    for_each = each.value.route_control_for_dampening
    content {
      af                     = "${relation_l3ext_rs_dampening_pol.value.address_family}-ucast"
      tn_rtctrl_profile_name = "uni/tn-${each.value.tenant}/prof-${relation_l3ext_rs_dampening_pol.value.route_map}"
    }
  }
  # relation_l3ext_rs_interleak_pol = "{route_profile_for_interleak}"
  # relation_l3ext_rs_out_to_bd_public_subnet_holder = ["{fvBDPublicSubnetHolder}"]
}

resource "aci_l3out_bgp_external_policy" "external_bgp" {
  depends_on = [
    aci_l3_outside.l3outs
  ]
  for_each      = { for k, v in local.l3outs : k => v if v.controller_type == "apic" && v.enable_bgp == true }
  l3_outside_dn = aci_l3_outside.l3outs[each.key].id
  annotation    = each.value.annotation != "" ? each.value.annotation : var.annotation
}


/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "l3extInstP"
 - Distinguised Name: "/uni/tn-{tenant}/out-{l3out}/instP-{Ext_EPG}"
GUI Location:
 - tenants > {tenant} > Networking > L3Outs > {l3out} > External EPGs > {Ext_EPG}
_______________________________________________________________________________________________________________________
*/
output "ext_epgs" {
  value = local.l3out_external_epgs
}
resource "aci_external_network_instance_profile" "l3out_external_epgs" {
  depends_on = [
    aci_l3_outside.l3outs
  ]
  for_each       = { for k, v in local.l3out_external_epgs : k => v if v.epg_type != "oob" }
  l3_outside_dn  = aci_l3_outside.l3outs[each.value.l3out].id
  annotation     = each.value.annotation != "" ? each.value.annotation : var.annotation
  description    = each.value.description
  exception_tag  = each.value.contract_exception_tag
  flood_on_encap = each.value.flood_on_encapsulation
  match_t        = each.value.match_type
  name_alias     = each.value.alias
  name           = each.value.name
  pref_gr_memb   = each.value.preferred_group_member == true ? "include" : "exclude"
  prio           = each.value.qos_class
  target_dscp    = each.value.target_dscp
  dynamic "relation_l3ext_rs_inst_p_to_profile" {
    for_each = each.value.route_control_profiles
    content {
      direction              = each.value.direction
      tn_rtctrl_profile_name = "uni/tn-${each.value.tenant}/prof-${relation_l3ext_rs_inst_p_to_profile.value.route_map}"
    }
  }
  # relation_l3ext_rs_l3_inst_p_to_dom_p        = each.value.L3_Domain
  # relation_fv_rs_cust_qos_pol = each.value.custom_qos_policy
  # relation_fv_rs_sec_inherited                = [each.value.l3out_contract_masters]
  # relation_l3ext_rs_inst_p_to_nat_mapping_epg = "aci_bridge_domain.{NAT_fvEPg}.id"
}

#------------------------------------------
# Create an Out-of-Band External EPG
#------------------------------------------

/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "mgmtInstP"
 - Distinguished Name: "uni/tn-mgmt/extmgmt-default/instp-{name}"
GUI Location:
 - tenants > mgmt > External Management Network Instance Profiles > {name}
_______________________________________________________________________________________________________________________
*/
resource "aci_rest_managed" "oob_external_epgs" {
  depends_on = [
    aci_l3_outside.l3outs
  ]
  for_each   = { for k, v in local.l3out_external_epgs : k => v if v.epg_type == "oob" }
  dn         = "uni/tn-mgmt/extmgmt-default/instp-{name}"
  class_name = "mgmtInstP"
  content = {
    annotation = each.value.annotation != "" ? each.value.annotation : var.annotation
    name       = each.value.name
  }
}

#------------------------------------------------
# Assign Contracts to an External EPG
#------------------------------------------------

/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "fvRsIntraEpg"
 - Distinguised Name: "/uni/tn-{tenant}/out-{l3out}/instP-{ext_epg}/rsintraEpg-{contract}"
GUI Location:
 - tenants > {tenant} > Networking > L3Outs > {l3out} > External EPGs > {ext_epg}: Contracts
_______________________________________________________________________________________________________________________
*/
resource "aci_rest_managed" "external_epg_intra_epg_contracts" {
  depends_on = [
    aci_external_network_instance_profile.l3out_external_epgs,
    aci_rest_managed.oob_external_epgs
  ]
  for_each   = { for k, v in local.l3out_ext_epg_contracts : k => v if v.controller_type == "apic" && v.contract_type == "intra_epg" }
  dn         = "uni/tn-${each.value.tenant}/out-${each.value.l3out}/instP-${each.value.epg}/rsintraEpg-${each.value.contract}"
  class_name = "fvRsIntraEpg"
  content = {
    tnVzBrCPName = each.value.contract
  }
}

/*_____________________________________________________________________________________________________________________

API Information:
 - Consumer Class: "fvRsCons"
 - Interface Class: "vzRsAnyToConsIf"
 - Provider Class: "fvRsProv"
 - Taboo Class: "fvRsProtBy"
 - Consumer Distinguised Name: "/uni/tn-{tenant}/out-{l3out}/instP-{ext_epg}/rsintraEpg-{contract}"
 - Interface Distinguised Name: "/uni/tn-{tenant}/out-{l3out}/instP-{ext_epg}/rsconsIf-{contract}"
 - Provider Distinguised Name: "/uni/tn-{tenant}/out-{l3out}/instP-{ext_epg}/rsprov-{contract}"
 - Taboo Distinguised Name: "/uni/tn-{tenant}/out-{l3out}/instP-{ext_epg}/rsprotBy-{contract}"
GUI Location:
 - All Contracts: tenants > {tenant} > Networking > L3Outs > {l3out} > External EPGs > {ext_epg}: Contracts
_______________________________________________________________________________________________________________________
*/
resource "aci_rest_managed" "external_epg_contracts" {
  depends_on = [
    aci_external_network_instance_profile.l3out_external_epgs,
    aci_rest_managed.oob_external_epgs
  ]
  for_each = { for k, v in local.l3out_ext_epg_contracts : k => v if v.controller_type == "apic" && v.contract_type != "intra_epg" }
  dn = length(regexall(
    "consumed", each.value.contract_type)
    ) > 0 ? "uni/tn-${each.value.tenant}/out-${each.value.l3out}/instP-${each.value.epg}/rscons-${each.value.contract}" : length(regexall(
    "interface", each.value.contract_type)
    ) > 0 ? "uni/tn-${each.value.tenant}/out-${each.value.l3out}/instP-${each.value.epg}/rsconsIf-${each.value.contract}" : length(regexall(
    "provided", each.value.contract_type)
    ) > 0 ? "uni/tn-${each.value.tenant}/out-${each.value.l3out}/instP-${each.value.epg}/rsprov-${each.value.contract}" : length(regexall(
    "taboo", each.value.contract_type)
  ) > 0 ? "uni/tn-${each.value.tenant}/out-${each.value.l3out}/instP-${each.value.epg}/rsprotBy-${each.value.contract}" : ""
  class_name = length(regexall(
    "consumed", each.value.contract_type)
    ) > 0 ? "fvRsCons" : length(regexall(
    "interface", each.value.contract_type)
    ) > 0 ? "vzRsAnyToConsIf" : length(regexall(
    "provided", each.value.contract_type)
    ) > 0 ? "fvRsProv" : length(regexall(
    "taboo", each.value.contract_type)
  ) > 0 ? "fvRsProtBy" : ""
  content = {
    tnVzBrCPName = each.value.contract
    prio         = each.value.qos_class
  }
}


#------------------------------------------------
# Assign a Subnet to an External EPG
#------------------------------------------------

/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "l3extSubnet"
 - Distinguised Name: "/uni/tn-{tenant}/out-{l3out}/instP-{ext_epg}/extsubnet-[{subnet}]"
GUI Location:
 - tenants > {tenant} > Networking > L3Outs > {l3out} > External EPGs > {ext_epg}
_______________________________________________________________________________________________________________________
*/
resource "aci_l3_ext_subnet" "external_epg_subnets" {
  depends_on = [
    aci_external_network_instance_profile.l3out_external_epgs
  ]
  for_each = { for k, v in local.l3out_external_epg_subnets : k => v if v.epg_type != "oob" }
  aggregate = anytrue(
    [each.value.aggregate_export, each.value.aggregate_shared_routes]
    ) ? replace(trim(join(",", concat([
      length(regexall(true, each.value.aggregate_export)) > 0 ? "export-rtctrl" : ""], [
      length(regexall(true, each.value.aggregate_shared_routes)) > 0 ? "shared-rtctrl" : ""]
  )), ","), ",,", ",") : "none"
  annotation                           = each.value.annotation != "" ? each.value.annotation : var.annotation
  description                          = each.value.description
  external_network_instance_profile_dn = aci_external_network_instance_profile.l3out_external_epgs[each.value.ext_epg].id
  ip                                   = each.value.subnet
  scope = anytrue(
    [
      each.value.export_route_control_subnet,
      each.value.external_subnets_for_external_epg,
      each.value.shared_security_import_subnet,
      each.value.shared_route_control_subnet
    ]
    ) ? compact(concat([
      length(regexall(true, each.value.export_route_control_subnet)) > 0 ? "export-rtctrl" : ""], [
      length(regexall(true, each.value.external_subnets_for_external_epg)) > 0 ? "import-security" : ""], [
      length(regexall(true, each.value.shared_security_import_subnet)) > 0 ? "shared-security" : ""], [
      length(regexall(true, each.value.shared_route_control_subnet)) > 0 ? "shared-rtctrl" : ""]
  )) : ["import-security"]
  dynamic "relation_l3ext_rs_subnet_to_profile" {
    for_each = each.value.route_control_profiles
    content {
      direction            = relation_l3ext_rs_subnet_to_profile.value.direction
      tn_rtctrl_profile_dn = "uni/tn-${relation_l3ext_rs_subnet_to_profile.value.tenant}/prof-${relation_l3ext_rs_subnet_to_profile.value.route_map}"
    }
  }
  relation_l3ext_rs_subnet_to_rt_summ = length(
    regexall("[:alnum:]", each.value.route_summarization_policy)
  ) > 0 ? "uni/tn-${each.value.policy_source_tenant}/bgprtsum-${each.value.route_summarization_policy}" : ""
}


#------------------------------------------------
# Assign a Subnet to an Out-of-Band External EPG
#------------------------------------------------

/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "mgmtSubnet"
 - Distinguished Name: "uni/tn-mgmt/extmgmt-default/instp-{ext_epg}/subnet-[{subnet}]"
GUI Location:
 - tenants > mgmt > External Management Network Instance Profiles > {ext_epg}: Subnets:{subnet}
_______________________________________________________________________________________________________________________
*/
resource "aci_rest_managed" "oob_external_epg_subnets" {
  depends_on = [
    aci_rest_managed.oob_external_epgs
  ]
  for_each   = { for k, v in local.l3out_external_epg_subnets : k => v if v.epg_type == "oob" }
  dn         = "uni/tn-mgmt/extmgmt-default/instp-${each.value.epg}/subnet-[${each.value.subnet}]"
  class_name = "mgmtSubnet"
  content = {
    ip = each.value.subnet
  }
}


/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "ospfExtP"
 - Distinguished Name: "/uni/tn-{tenant}/out-{l3out}/ospfExtP"
GUI Location:
 - tenants > {tenant} > Networking > L3Outs > {l3out}: OSPF
_______________________________________________________________________________________________________________________
*/
#------------------------------------------------
# Assign a OSPF Routing Policy to the L3Out
#------------------------------------------------
resource "aci_l3out_ospf_external_policy" "l3out_ospf_external_policies" {
  depends_on = [
    aci_l3_outside.l3outs
  ]
  for_each   = local.l3out_ospf_external_policies
  annotation = each.value.annotation != "" ? each.value.annotation : var.annotation
  area_cost  = each.value.ospf_area_cost
  area_ctrl = anytrue([
    each.value.send_redistribution_lsas_into_nssa_area,
    each.value.originate_summary_lsa,
    each.value.suppress_forwarding_address
    ]) ? compact(concat([
      length(regexall(true, each.value.send_redistribution_lsas_into_nssa_area)) > 0 ? "redistribute" : ""], [
      length(regexall(true, each.value.originate_summary_lsa)) > 0 ? "summary" : ""], [
    length(regexall(true, each.value.suppress_forwarding_address)) > 0 ? "suppress-fa" : ""]
  )) : ["redistribute", "summary"]
  area_id       = each.value.ospf_area_id
  area_type     = each.value.ospf_area_type
  l3_outside_dn = aci_l3_outside.l3outs[each.value.l3out].id
  # multipod_internal = "no"
}
