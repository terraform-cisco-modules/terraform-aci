/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "cdpIfPol"
 - Distinguished Name: "uni/infra/cdpIfP-{name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > CDP Interface : {name}
_______________________________________________________________________________________________________________________
*/
variable "cdp_interface_policies" {
  default = {
    "default" = {
      admin_state  = "enabled"
      annotation   = ""
      description  = ""
      global_alias = ""
    }
  }
  description = <<-EOT
  Key: Name of the CDP Interface Policy.
  * admin_state: (Default value is "enabled").  The State of the CDP Protocol on the Interface.
  * annotation: A search keyword or term that is assigned to the Object. Tags allow you to group multiple objects by descriptive names. You can assign the same tag name to multiple objects and you can assign one or more tag names to a single object.
  * description: Description to add to the Object.  The description can be up to 128 alphanumeric characters.
  * global_alias: A label, unique within the fabric, that can serve as a substitute for an object's Distinguished Name (DN).  A global alias must be unique accross the fabric.
  EOT
  type = map(object(
    {
      admin_state  = optional(string)
      alias        = optional(string)
      annotation   = optional(string)
      description  = optional(string)
      global_alias = ""
    }
  ))
}


resource "aci_cdp_interface_policy" "cdp_interface_policies" {
  for_each    = local.cdp_interface_policies
  annotation  = each.value.annotation != "" ? each.value.annotation : var.annotation
  admin_st    = each.value.admin_state
  description = each.value.description
  name        = each.key
}


/*_____________________________________________________________________________________________________________________

Fibre-Channel Interface Policy Variables
_______________________________________________________________________________________________________________________
*/
variable "fibre_channel_interface_policies" {
  default = {
    "default" = {
      annotation            = ""
      auto_max_speed        = "32G"
      description           = ""
      fill_pattern          = "ARBFF"
      port_mode             = "f"
      receive_buffer_credit = 64
      speed                 = "auto"
      trunk_mode            = "trunk-off"
    }
  }
  description = <<-EOT
  Key: Name of the Fibre-Channel Interface Policy.
  * annotation: A search keyword or term that is assigned to the Object. Tags allow you to group multiple objects by descriptive names. You can assign the same tag name to multiple objects and you can assign one or more tag names to a single object.
  * auto_max_speed: (Default value is "32G").  Auto-max-speed for object interface FC policy. Allowed values are:
    - 4G
    - 8G
    - 16G
    - 32G
  * description: Description to add to the Object.  The description can be up to 128 alphanumeric characters.
  * fill_pattern: (Default value is "ARBFF").  Fill Pattern for native FC ports. Allowed values are:
    - ARBFF
    - IDLE
  * port_mode: (Default value is "f").  In which mode Ports should be used. Allowed values are "f" and "np".
  * receive_buffer_credit: (Default value is 64).  Receive buffer credits for native FC ports Range:(16 - 64).
  * speed: (Default value is "auto").  CPU or port speed. All the supported values are:
    - unknown
    - auto
    - 4G
    - 8G
    - 16G
    - 32G
  * trunk_mode: (Default value is "trunk-off").  Trunking on/off for native FC ports. Allowed values are:
    - un-init
    - trunk-off
    - trunk-on
    - auto
  EOT
  type = map(object(
    {
      auto_max_speed        = optional(string)
      description           = optional(string)
      fill_pattern          = optional(string)
      port_mode             = optional(string)
      receive_buffer_credit = optional(number)
      speed                 = optional(string)
      annotation            = optional(string)
      trunk_mode            = optional(string)
    }
  ))
}


/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "fcIfPol"
 - Distinguished Name: "uni/infra/fcIfPol-{name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > Fibre Channel Interface : {name}
_______________________________________________________________________________________________________________________
*/
resource "aci_interface_fc_policy" "fibre_channel_interface_policies" {
  for_each     = local.fibre_channel_interface_policies
  annotation   = each.value.annotation != "" ? each.value.annotation : var.annotation
  automaxspeed = each.value.auto_max_speed
  description  = each.value.description
  fill_pattern = each.value.fill_pattern
  name         = each.key
  port_mode    = each.value.port_mode
  rx_bb_credit = each.value.receive_buffer_credit
  speed        = each.value.speed
  trunk_mode   = each.value.trunk_mode
}


/*_____________________________________________________________________________________________________________________

L2 Interface Policy Variables
_______________________________________________________________________________________________________________________
*/
variable "l2_interface_policies" {
  default = {
    "default" = {
      annotation       = ""
      description      = ""
      qinq             = "disabled"
      reflective_relay = "disabled"
      vlan_scope       = "global"
    }
  }
  description = <<-EOT
  Key: Name of the Layer2 Interface Policy.
  * annotation: A search keyword or term that is assigned to the Object. Tags allow you to group multiple objects by descriptive names. You can assign the same tag name to multiple objects and you can assign one or more tag names to a single object.
  * description: Description to add to the Object.  The description can be up to 128 alphanumeric characters.
  * qinq: (Default value is "disabled").  To enable or disable an interface for Dot1q Tunnel or Q-in-Q encapsulation modes, select one of the following:
    - corePort: Configure this core-switch interface to be included in a Dot1q Tunnel.  You can configure multiple corePorts, for multiple customers, to be used in a Dot1q Tunnel.
    - disabled: Disable this interface to be used in a Dot1q Tunnel.
    - doubleQtagPort: Configure this interface to be used for Q-in-Q encapsulated traffic.
    - edgePort: Configure this edge-switch interface (for a single customer) to be included in a Dot1q Tunnel.
  * reflective_relay: (Default value is "disabled").  Enable or disable reflective relay for ports that consume the policy.
  * vlan_scope: (Default value is "global").  The layer 2 interface VLAN scope. The scope can be:
    - global: Sets the VLAN encapsulation value to map only to a single EPG per leaf.
    - portlocal: Allows allocation of separate (Port, Vlan) translation entries in both ingress and egress directions. This configuration is not valid when the EPGs belong to a single bridge domain.
    VLAN Scope is not supported if edgePort is selected in the QinQ field.
    Note:  Changing the VLAN scope from Global to Port Local or Port Local to Global will cause the ports where this policy is applied to flap and traffic will be disrupted.
  EOT
  type = map(object(
    {
      annotation       = optional(string)
      description      = optional(string)
      qinq             = optional(string)
      reflective_relay = optional(string)
      vlan_scope       = optional(string)
    }
  ))
}

/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "l2IfPol"
 - Distinguished Name: "uni/infra/l2IfP-{name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > L2 Interface : {name}
_______________________________________________________________________________________________________________________
*/
resource "aci_l2_interface_policy" "l2_interface_policies" {
  for_each    = local.l2_interface_policies
  annotation  = each.value.annotation != "" ? each.value.annotation : var.annotation
  description = each.value.description
  name        = each.key
  qinq        = each.value.qinq
  vepa        = each.value.reflective_relay
  vlan_scope  = each.value.vlan_scope
}


/*_____________________________________________________________________________________________________________________

Link Level Policy Variables
_______________________________________________________________________________________________________________________
*/
variable "link_level_policies" {
  default = {
    "default" = {
      annotation                  = ""
      auto_negotiation            = true
      description                 = ""
      forwarding_error_correction = "inherit"
      global_alias                = ""
      link_debounce_interval      = 100
      speed                       = "inherit"
    }
  }
  description = <<-EOT
  Key: Name of the Link Level Policy.
  * annotation: A search keyword or term that is assigned to the Object. Tags allow you to group multiple objects by descriptive names. You can assign the same tag name to multiple objects and you can assign one or more tag names to a single object.
  * auto_negotiation: (Default value is true).  Policy auto negotiation for object fabric if pol. Allowed values:
    - off
    - on
    - on-enforce
  * description: Description to add to the Object.  The description can be up to 128 alphanumeric characters.
  * global_alias: A label, unique within the fabric, that can serve as a substitute for an object's Distinguished Name (DN).  A global alias must be unique accross the fabric.
  * forwarding_error_correction: (Default value is "inherit").  Forwarding error correction for object fabric if pol. Allowed values: 
    - inherit
    - cl91-rs-fec
    - cl74-fc-fec
    - ieee-rs-fec
    - cons16-rs-fec
    - kp-fec
    - disable-fec
  * link_debounce_interval: (Default value is 100).  Link debounce interval for object fabric if pol. Range of allowed values: 0-5000.
  * speed: (Default value is "inherit").  Port speed for object fabric if pol. Allowed values: 
    - unknown
    - 100M
    - 1G
    - 10G
    - 25G
    - 40G
    - 50G
    - 100G
    - 200G
    - 400G
    * inherit
  EOT
  type = map(object(
    {
      annotation                  = optional(string)
      auto_negotiation            = optional(string)
      description                 = optional(string)
      forwarding_error_correction = optional(string)
      global_alias                = optional(string)
      link_debounce_interval      = optional(number)
      speed                       = optional(string)
    }
  ))
}


/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "fabricHIfPol"
 - Distinguished Name: "uni/infra/hintfpol-{name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > Link Level : {name}
_______________________________________________________________________________________________________________________
*/
resource "aci_fabric_if_pol" "link_level_policies" {
  for_each      = local.link_level_policies
  annotation    = each.value.annotation != "" ? each.value.annotation : var.annotation
  auto_neg      = each.value.auto_negotiation
  description   = each.value.description
  fec_mode      = each.value.forwarding_error_correction
  link_debounce = each.value.link_debounce_interval
  name          = each.key
  speed         = each.value.speed
}


/*_____________________________________________________________________________________________________________________

LLDP Interface Policy Variables
_______________________________________________________________________________________________________________________
*/
variable "lldp_interface_policies" {
  default = {
    "default" = {
      annotation     = ""
      description    = ""
      global_alias   = ""
      receive_state  = "enabled"
      transmit_state = "enabled"
    }
  }
  description = <<-EOT
  Key: Name of the LLDP Interface Policy.
  * annotation: A search keyword or term that is assigned to the Object. Tags allow you to group multiple objects by descriptive names. You can assign the same tag name to multiple objects and you can assign one or more tag names to a single object.
  * description: Description to add to the Object.  The description can be up to 128 alphanumeric characters.
  * global_alias: A label, unique within the fabric, that can serve as a substitute for an object's Distinguished Name (DN).  A global alias must be unique accross the fabric.
  * receive_state: (Default value is "enabled").  The reception of LLDP packets on an interface. 
  * transmit_state: (Default value is "enabled").  The transmission of LLDP packets on an interface. 
  EOT
  type = map(object(
    {
      annotation     = optional(string)
      description    = optional(string)
      global_alias   = optional(string)
      receive_state  = optional(string)
      transmit_state = optional(string)
    }
  ))
}


/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "lldpIfPol"
 - Distinguished Name: "uni/infra/lldpIfP-{name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > LLDP Interface : {name}
_______________________________________________________________________________________________________________________
*/
resource "aci_lldp_interface_policy" "lldp_interface_policies" {
  for_each    = local.lldp_interface_policies
  admin_rx_st = each.value.receive_state
  admin_tx_st = each.value.transmit_state
  annotation  = each.value.annotation != "" ? each.value.annotation : var.annotation
  description = each.value.description
  name        = each.key
}


/*_____________________________________________________________________________________________________________________

MCP Interface Policy Variables
_______________________________________________________________________________________________________________________
*/
variable "mcp_interface_policies" {
  default = {
    "default" = {
      admin_state = "enabled"
      annotation  = ""
      description = ""
    }
  }
  description = <<-EOT
  Key: Name of the MCP Interface Policy.
  * admin_state: (Default value is "enabled").  The administrative state of the MCP interface policy. The state can be:
  * annotation: A search keyword or term that is assigned to the Object. Tags allow you to group multiple objects by descriptive names. You can assign the same tag name to multiple objects and you can assign one or more tag names to a single object.
  * description: Description to add to the Object.  The description can be up to 128 alphanumeric characters.
  EOT
  type = map(object(
    {
      admin_state = optional(string)
      annotation  = optional(string)
      description = optional(string)
    }
  ))
}


/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "mcpIfPol"
 - Distinguished Name: "uni/infra/mcpIfP-{name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > MCP Interface : {name}
_______________________________________________________________________________________________________________________
*/
resource "aci_miscabling_protocol_interface_policy" "mcp_interface_policies" {
  for_each    = local.mcp_interface_policies
  annotation  = each.value.annotation != "" ? each.value.annotation : var.annotation
  admin_st    = each.value.admin_state
  description = each.value.description
  name        = each.key
}


/*_____________________________________________________________________________________________________________________

Port-Channel Policy Variables
_______________________________________________________________________________________________________________________
*/
variable "port_channel_policies" {
  default = {
    "default" = {
      annotation = ""
      control = [
        {
          fast_select_hot_standby_ports = true
          graceful_convergence          = true
          load_defer_member_ports       = false
          suspend_individual_port       = true
          symmetric_hashing             = false
        }
      ]
      description             = ""
      global_alias            = ""
      maximum_number_of_links = 16
      minimum_number_of_links = 1
      mode                    = "off"
    }
  }
  description = <<-EOT
  Key: Name of the LACP Interface Policy.
  * annotation: A search keyword or term that is assigned to the Object. Tags allow you to group multiple objects by descriptive names. You can assign the same tag name to multiple objects and you can assign one or more tag names to a single object.
  * control: LACP Control Parameters:
    - fast_select_hot_standby_ports: (Default value is true).  Configures fast select for hot standby ports. Enabling this feature will allow fast selection of a hot standby port when last active port in the port-channel is going down.
    - graceful_convergence: (Default value is true).  Configures port-channel LACP graceful convergence. Disable this only with LACP ports connected to a Non-Nexus peer. Disabling this with Nexus peer can lead to port suspension.
    - load_defer_member_ports: (Default value is false).  Configures the load-balancing algorithm for port channels that applies to the entire device or to only one module.
    - suspend_individual_port: (Default value is true).  LACP sets a port to the suspended state if it does not receive an LACP bridge protocol data unit (BPDU) from the peer ports in a port channel. This can cause some servers to fail to boot up as they require LACP to logically bring up the port.
    - symmetric_hashing: (Default value is false).  Bidirectional traffic is forced to use the same physical interface and each physical interface in the port channel is effectively mapped to a set of flows.
  * description: Description to add to the Object.  The description can be up to 128 alphanumeric characters.
  * global_alias: A label, unique within the fabric, that can serve as a substitute for an object's Distinguished Name (DN).  A global alias must be unique accross the fabric.
  * maximum_number_of_links: (Default value is 16).  Maximum number of links. Allowed value range is 1-16.
  * minimum_number_of_links: (Default value is 1).  Minimum number of links in port channel. Allowed value range is 1-16. 
  * mode: (Default value is "off").  port-channel policy mode. 
    - active: LACP mode that places a port into an active negotiating state in which the port initiates negotiations with other ports by sending LACP packets.
    - mac-pin: Used for pinning VM traffic in a round-robin fashion to each uplink based on the MAC address of the VM. MAC Pinning is the recommended option for channeling when connecting to upstream switches that do not support multichassis EtherChannel (MEC).
    - mac-pin-nicload: Pins VM traffic in a round-robin fashion to each uplink based on the MAC address of the physical NIC.
    - off: All static port channels (that are not running LACP) remain in this mode. If you attempt to change the channel mode to active or passive before enabling LACP, the device displays an error message.
    - passive: LACP mode that places a port into a passive negotiating state in which the port responds to LACP packets that it receives but does not initiate LACP negotiation. Passive mode is useful when you do not know whether the remote system, or partner, supports LACP.
  EOT
  type = map(object(
    {
      annotation = optional(string)
      control = optional(list(object(
        {
          fast_select_hot_standby_ports = optional(bool)
          graceful_convergence          = optional(bool)
          load_defer_member_ports       = optional(bool)
          suspend_individual_port       = optional(bool)
          symmetric_hashing             = optional(bool)
        }
      )))
      description             = optional(string)
      global_alias            = optional(string)
      maximum_number_of_links = optional(number)
      minimum_number_of_links = optional(number)
      mode                    = optional(string)
    }
  ))
}


/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "lacpLagPol"
 - Distinguished Name: "uni/infra/lacplagp-{name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > Port Channel : {name}
_______________________________________________________________________________________________________________________
*/
resource "aci_lacp_policy" "port_channel_policies" {
  for_each   = local.port_channel_policies
  annotation = each.value.annotation != "" ? each.value.annotation : var.annotation
  ctrl = anytrue(
    [each.value.control[0]["fast_select_hot_standby_ports"
      ], each.value.control[0]["graceful_convergence"
      ], each.value.control[0]["load_defer_member_ports"
      ], each.value.control[0]["suspend_individual_port"
      ], each.value.control[0]["symmetric_hashing"]]) ? compact(concat(
      [length(regexall(true, each.value.control[0].fast_select_hot_standby_ports)
        ) > 0 ? "fast-sel-hot-stdby" : ""
        ], [length(regexall(true, each.value.control[0].graceful_convergence)
        ) > 0 ? "graceful-conv" : ""
        ], [length(regexall(true, each.value.control[0].load_defer_member_ports)
        ) > 0 ? "load-defer" : ""
        ], [length(regexall(true, each.value.control[0].suspend_individual_port)
        ) > 0 ? "susp-individual" : ""
        ], [length(regexall(true, each.value.control[0].symmetric_hashing)
    ) > 0 ? "symmetric-hash" : ""])) : [
  "fast-sel-hot-stdby", "graceful-conv", "susp-individual"]
  description = each.value.description
  max_links   = each.value.maximum_number_of_links
  min_links   = each.value.minimum_number_of_links
  name        = each.key
  mode        = each.value.mode
}


/*_____________________________________________________________________________________________________________________

Port Security Policy Variables
_______________________________________________________________________________________________________________________
*/
variable "port_security_policies" {
  default = {
    "default" = {
      annotation            = ""
      description           = ""
      maximum_endpoints     = 0
      port_security_timeout = 60
    }
  }
  description = <<-EOT
  Key: Name of the Port Security Policy.
  * annotation: A search keyword or term that is assigned to the Object. Tags allow you to group multiple objects by descriptive names. You can assign the same tag name to multiple objects and you can assign one or more tag names to a single object.
  * description: Description to add to the Object.  The description can be up to 128 alphanumeric characters.
  * maximum_endpoints: (Default value is 0).  The maximum number of endpoints that can be learned on the interface. The current supported range for the maximum endpoints configured value is from 0 to 12000. If the maximum endpoints value is 0, the port security policy is disabled on that port.
  * port_security_timeout: (Default value is 60).  The delay time before MAC learning is re-enabled. The current supported range for the timeout value is from 60 to 3600.
  EOT
  type = map(object(
    {
      annotation            = optional(string)
      description           = optional(string)
      maximum_endpoints     = optional(number)
      port_security_timeout = optional(number)
    }
  ))
}

/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "l2PortSecurityPol"
 - Distinguished Name: "uni/infra/portsecurityP-{name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > Port Security : {name}
_______________________________________________________________________________________________________________________
*/
resource "aci_port_security_policy" "port_security_policies" {
  for_each    = local.port_security_policies
  annotation  = each.value.annotation != "" ? each.value.annotation : var.annotation
  description = each.value.description
  maximum     = each.value.maximum_endpoints
  name        = each.key
  timeout     = each.value.port_security_timeout
  violation   = "protect"
}


/*_____________________________________________________________________________________________________________________

Spanning-Tree Interface Policy Variables
_______________________________________________________________________________________________________________________
*/
variable "spanning_tree_interface_policies" {
  default = {
    "default" = {
      annotation   = ""
      bpdu_filter  = "disabled"
      bpdu_guard   = "disabled"
      description  = ""
      global_alias = ""
    }
  }
  description = <<-EOT
  Key: Name of the Spanning-Tree Interface Policy.
  * annotation: A search keyword or term that is assigned to the Object. Tags allow you to group multiple objects by descriptive names. You can assign the same tag name to multiple objects and you can assign one or more tag names to a single object.
  * bpdu_filter_enabled: (Default value is false).  The interface level control that enables the BPDU filter for extended chassis ports.
  * bpdu_guard_enabled: (Default value is false).  The interface level control that enables the BPDU guard for extended chassis ports.
  * description: Description to add to the Object.  The description can be up to 128 alphanumeric characters.
  * global_alias: A label, unique within the fabric, that can serve as a substitute for an object's Distinguished Name (DN).  A global alias must be unique accross the fabric.
  EOT
  type = map(object(
    {
      annotation   = optional(string)
      bpdu_filter  = optional(string)
      bpdu_guard   = optional(string)
      description  = optional(string)
      global_alias = optional(string)
    }
  ))
}


/*_____________________________________________________________________________________________________________________

API Information:
 - Class: "stpIfPol"
 - Distinguished Name: "uni/infra/ifPol-{name}"
GUI Location:
 - Fabric > Access Policies > Policies > Interface > Spanning Tree Interface : {name}
_______________________________________________________________________________________________________________________
*/
resource "aci_spanning_tree_interface_policy" "spanning_tree_interface_policies" {
  for_each   = local.spanning_tree_interface_policies
  annotation = each.value.annotation != "" ? each.value.annotation : var.annotation
  ctrl = alltrue(concat(
    [each.value.bpdu_filter == "enabled" ? true : false],
    [each.value.bpdu_guard == "enabled" ? true : false]
    )) ? ["bpdu-filter", "bpdu-guard"] : anytrue(concat(
    [each.value.bpdu_filter == "enabled" ? true : false],
    [each.value.bpdu_guard == "enabled" ? true : false]
    )) ? compact(
    [each.value.bpdu_filter == "enabled" ? "bpdu-filter" : ""],
    [each.value.bpdu_guard == "enabled" ? "bpdu-guard" : ""]
  ) : ["unspecified"]
  description = each.value.description
  name        = each.key
}
