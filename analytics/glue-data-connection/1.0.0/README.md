# AWS Glue Data Connection Terraform Module

This Terraform module creates AWS Glue Connections for various data sources including JDBC databases, MongoDB, Kafka, and other supported connection types. The module provides flexible configuration options with backward compatibility support.

## 🚀 Features

- **Multi-Protocol Support**: JDBC, MongoDB, Kafka, API, and custom connections
- **Dynamic Configuration**: Flexible key-value connection properties
- **VPC Integration**: Optional physical connection requirements for secure networking
- **Backward Compatibility**: Supports legacy variable structure during migration
- **Validation**: Built-in input validation and error handling
- **Tagging Support**: Full AWS resource tagging capabilities

## 📋 Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## 🔧 Usage

### Basic JDBC Connection

```hcl
module "postgres_connection" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//analytics/glue-data-connection/1.0.0"

  connection_name = "postgres-analytics-db"
  
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:postgresql://my-db.cluster-xyz.region.rds.amazonaws.com:5432/analytics"
    USERNAME           = "glue_user"
    PASSWORD           = "secure_password"
  }

  physical_connection_requirements = {
    availability_zone      = "us-east-1a"
    security_group_id_list = ["sg-12345678"]
    subnet_id              = "subnet-abcdef12"
  }

  tags = {
    Environment = "production"
    Project     = "data-analytics"
    Team        = "data-engineering"
  }
}
```

### Secure Connection with AWS Secrets Manager

```hcl
module "secure_mysql_connection" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//analytics/glue-data-connection/1.0.0"

  connection_name = "mysql-secure-connection"
  
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:mysql://rds.amazonaws.com:3306/production"
    SECRET_ID          = "arn:aws:secretsmanager:us-east-1:123456789012:secret:rds/credentials"
  }

  physical_connection_requirements = {
    availability_zone      = "us-east-1b"
    security_group_id_list = ["sg-database", "sg-glue-access"]
    subnet_id              = "subnet-private-db"
  }

  tags = {
    Environment = "production"
    Encrypted   = "true"
    Compliance  = "PCI-DSS"
  }
}
```

### MongoDB Connection

```hcl
module "mongodb_connection" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//analytics/glue-data-connection/1.0.0"

  connection_name = "mongodb-analytics"
  
  connection_properties = {
    CONNECTION_URL  = "mongodb://mongo.internal:27017/analytics"
    CONNECTION_TYPE = "mongodb"
    USERNAME       = "analytics_user"
    PASSWORD       = "mongo_password"
  }

  tags = {
    Environment = "staging"
    Database    = "mongodb"
    Purpose     = "analytics"
  }
}
```

### Kafka Streaming Connection

```hcl
module "kafka_connection" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//analytics/glue-data-connection/1.0.0"

  connection_name = "kafka-real-time-data"
  
  connection_properties = {
    KAFKA_BOOTSTRAP_SERVERS = "broker1:9092,broker2:9092,broker3:9092"
    KAFKA_SSL_ENABLED      = "true"
    KAFKA_SECURITY_PROTOCOL = "SSL"
  }

  physical_connection_requirements = {
    availability_zone      = "us-east-1c"
    security_group_id_list = ["sg-kafka-access"]
    subnet_id              = "subnet-kafka-private"
  }

  tags = {
    Environment = "production"
    Service     = "kafka"
    DataType    = "streaming"
  }
}
```

## 📊 Connection Types Supported

| Type | Connection Properties | Use Case |
|------|----------------------|----------|
| **JDBC** | `JDBC_CONNECTION_URL`, `USERNAME`, `PASSWORD`, `SECRET_ID` | PostgreSQL, MySQL, SQL Server, Oracle |
| **MongoDB** | `CONNECTION_URL`, `CONNECTION_TYPE`, `USERNAME`, `PASSWORD` | Document databases |
| **Kafka** | `KAFKA_BOOTSTRAP_SERVERS`, `KAFKA_SSL_ENABLED` | Real-time streaming |
| **API** | `API_URL`, `SECRET_ID`, `API_KEY` | REST/GraphQL APIs |
| **Custom** | Any key-value pairs | Custom data sources |

## 📋 Inputs

### Required Variables

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| `connection_name` | Unique name for the Glue connection | `string` | ✅ |
| `connection_properties` | Key-value pairs for connection configuration | `map(string)` | ✅ |
| `tags` | AWS resource tags | `map(string)` | ✅ |

### Optional Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `physical_connection_requirements` | VPC networking configuration | `object` | `null` |

### Physical Connection Requirements Object

```hcl
physical_connection_requirements = {
  availability_zone      = string       # AZ for connection endpoint
  security_group_id_list = list(string) # Security groups for network access
  subnet_id              = string       # Subnet for connection endpoint
}
```

### Deprecated Variables (Legacy Support)

| Name | Description | Migration |
|------|-------------|-----------|
| `jdbc_connection_url` | JDBC URL | → `connection_properties.JDBC_CONNECTION_URL` |
| `secret_id` | Secrets Manager ARN | → `connection_properties.SECRET_ID` |
| `availability_zone` | AZ for connection | → `physical_connection_requirements.availability_zone` |
| `security_group_id_list` | Security groups | → `physical_connection_requirements.security_group_id_list` |
| `subnet_id` | Subnet ID | → `physical_connection_requirements.subnet_id` |

## 📤 Outputs

| Name | Description |
|------|-------------|
| `arn` | ARN of the created Glue connection |
| `id` | ID of the created Glue connection |

## 🔄 Migration Guide

### Legacy to Modern Syntax

**Before (Deprecated):**
```hcl
module "glue_connection" {
  source = "..."
  
  connection_name        = "my-connection"
  jdbc_connection_url    = "jdbc:postgresql://db:5432/mydb"
  secret_id              = "arn:aws:secretsmanager:..."
  availability_zone      = "us-east-1a"
  security_group_id_list = ["sg-12345"]
  subnet_id              = "subnet-67890"
  tags                   = { Environment = "prod" }
}
```

**After (Recommended):**
```hcl
module "glue_connection" {
  source = "..."
  
  connection_name = "my-connection"
  
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:postgresql://db:5432/mydb"
    SECRET_ID          = "arn:aws:secretsmanager:..."
  }
  
  physical_connection_requirements = {
    availability_zone      = "us-east-1a"
    security_group_id_list = ["sg-12345"]
    subnet_id              = "subnet-67890"
  }
  
  tags = { Environment = "prod" }
}
```

## 🏗️ Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Glue ETL Job  │────│  Glue Connection │────│   Data Source   │
│                 │    │                  │    │ (RDS/MongoDB/   │
│                 │    │ • Network Config │    │  Kafka/API)     │
│                 │    │ • Credentials    │    │                 │
│                 │    │ • Properties     │    │                 │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                               │
                               ▼
                    ┌──────────────────┐
                    │   VPC Network    │
                    │ • Security Groups│
                    │ • Subnets        │
                    │ • Endpoints      │
                    └──────────────────┘
```

## 🔍 Examples

See the [examples](./example/) directory for comprehensive usage examples including:
- Basic JDBC connections
- Secure connections with Secrets Manager
- MongoDB document database connections
- Kafka streaming connections
- Legacy variable migration examples

## 🚨 Important Notes

1. **Security**: Always use AWS Secrets Manager for database credentials in production
2. **Networking**: Physical connection requirements are mandatory for VPC-based data sources
3. **Migration**: Legacy variables are deprecated but supported for backward compatibility
4. **Validation**: At least one connection property must be specified
5. **Tagging**: Consistent tagging strategy is recommended for resource management

## 📚 Resources

- [AWS Glue Connection Documentation](https://docs.aws.amazon.com/glue/latest/dg/connection-defining.html)
- [Terraform AWS Glue Connection Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_connection)
- [AWS Glue Best Practices](https://docs.aws.amazon.com/glue/latest/dg/best-practices.html)  
- Kafka connections
- Custom API connections
- Any AWS Glue supported connection type

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_glue_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Name of the Glue connection | `string` | n/a | yes |
| <a name="input_connection_properties"></a> [connection\_properties](#input\_connection\_properties) | A map of key-value pairs used as parameters for this connection. Supports JDBC, MongoDB, Kafka, and other connection types | `map(string)` | `{}` | no |
| <a name="input_physical_connection_requirements"></a> [physical\_connection\_requirements](#input\_physical\_connection\_requirements) | Physical connection requirements for the Glue connection. Set to null to skip physical connection requirements | <pre>object({<br>    availability_zone      = string<br>    security_group_id_list = list(string)<br>    subnet_id              = string<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the Glue connection | `map(string)` | `{}` | no |

### Legacy Variables (Deprecated)

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_jdbc_connection_url"></a> [jdbc\_connection\_url](#input\_jdbc\_connection\_url) | [DEPRECATED] Use connection_properties instead. JDBC connection URL for the Glue connection | `string` | `null` | no |
| <a name="input_secret_id"></a> [secret\_id](#input\_secret\_id) | [DEPRECATED] Use connection_properties instead. Secret ID for the Glue connection | `string` | `null` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | [DEPRECATED] Use physical_connection_requirements instead. Availability zone for the Glue connection | `string` | `null` | no |
| <a name="input_security_group_id_list"></a> [security\_group\_id\_list](#input\_security\_group\_id\_list) | [DEPRECATED] Use physical_connection_requirements instead. List of security group IDs for the Glue connection | `list(string)` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | [DEPRECATED] Use physical_connection_requirements instead. Subnet ID for the Glue connection | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the Glue connection |
| <a name="output_id"></a> [id](#output\_id) | ID of the Glue connection |

## Migration Guide

### From Legacy Variables to Dynamic Structure

**Old Way (Still Supported):**
```hcl
module "glue_connection" {
  source = "./modules/glue-data-connection"
  
  connection_name        = "my-connection"
  jdbc_connection_url    = "jdbc:mysql://db:3306/mydb"
  secret_id              = "secret-arn"
  availability_zone      = "us-east-1a"
  security_group_id_list = ["sg-xxx"]
  subnet_id              = "subnet-xxx"
}
```

**New Way (Recommended):**
```hcl
module "glue_connection" {
  source = "./modules/glue-data-connection"
  
  connection_name = "my-connection"
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:mysql://db:3306/mydb"
    SECRET_ID           = "secret-arn"
  }
  physical_connection_requirements = {
    availability_zone      = "us-east-1a"
    security_group_id_list = ["sg-xxx"]
    subnet_id              = "subnet-xxx"
  }
}
```
