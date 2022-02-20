resource "aci_ospf_route_summarization" "example" {
  depends_on = [
    aci_tenant.tenants
  ]
  tenant_dn          = aci_tenant.tenants[each.value.tenant].id
  description        = "from terraform"
  name               = "ospf_route_summarization_1"
  annotation         = "ospf_route_summarization_tag"
  cost               = "1"
  inter_area_enabled = "no"
  name_alias         = "example"
  tag                = "1"
}
# Argument Reference
# tenant_dn - (Required) Distinguished name of parent tenant object.
# name - (Required) Name of object OSPF route summarization.
# annotation - (Optional) Annotation for object OSPF route summarization.
# description - Description for for object OSPF route summarization.
# cost - (Optional) The OSPF Area cost for the default summary LSAs. The Area cost is used with NSSA and stub area types only. Range of allowed values is "0" to "16777215". Default value: "unspecified".
# inter_area_enabled - (Optional) Inter area enabled flag for object OSPF route summarization. Allowed values: "no", "yes". Default value: "no".
# name_alias - (Optional) Name name_alias for object OSPF route summarization.
# tag - (Optional) The color of a policy label. Default value: "0".