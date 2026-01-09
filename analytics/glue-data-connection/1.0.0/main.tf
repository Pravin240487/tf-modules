# AWS Glue Connection for data source connectivity
resource "aws_glue_connection" "this" {
  name = var.connection_name

  # Merge connection properties with legacy variable support
  connection_properties = merge(
    var.connection_properties,
    var.jdbc_connection_url != null ? { JDBC_CONNECTION_URL = var.jdbc_connection_url } : {},
    var.secret_id != null ? { SECRET_ID = var.secret_id } : {}
  )

  # Configure VPC networking when required
  dynamic "physical_connection_requirements" {
    for_each = var.physical_connection_requirements != null ? [var.physical_connection_requirements] : (
      var.availability_zone != null && var.security_group_id_list != null && var.subnet_id != null ? [{
        availability_zone      = var.availability_zone
        security_group_id_list = var.security_group_id_list
        subnet_id              = var.subnet_id
      }] : []
    )
    content {
      availability_zone      = physical_connection_requirements.value.availability_zone
      security_group_id_list = physical_connection_requirements.value.security_group_id_list
      subnet_id              = physical_connection_requirements.value.subnet_id
    }
  }

  tags = var.tags
}