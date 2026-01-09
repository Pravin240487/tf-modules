## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cognito_identity_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_identity_provider) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_idp_attributes"></a> [idp\_attributes](#input\_idp\_attributes) | Mapping of user attributes from the identity provider to Cognito User Pool attributes | `map(string)` | <pre>{<br/>  "custom:object_id": "objectid",<br/>  "email": "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress",<br/>  "family_name": "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname",<br/>  "given_name": "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname",<br/>  "name": "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"<br/>}</pre> | no |
| <a name="input_idp_signout"></a> [idp\_signout](#input\_idp\_signout) | Whether to enable identity provider initiated sign-out | `bool` | n/a | yes |
| <a name="input_metadata_url"></a> [metadata\_url](#input\_metadata\_url) | The URL of the SAML metadata document or OIDC discovery endpoint | `string` | n/a | yes |
| <a name="input_provider_name"></a> [provider\_name](#input\_provider\_name) | The name of the identity provider. Must be unique within the user pool | `string` | n/a | yes |
| <a name="input_provider_type"></a> [provider\_type](#input\_provider\_type) | The type of identity provider (SAML or OIDC) | `string` | n/a | yes |
| <a name="input_user_pool_id"></a> [user\_pool\_id](#input\_user\_pool\_id) | The ID of the Cognito User Pool to associate with the identity provider | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_provider_name"></a> [provider\_name](#output\_provider\_name) | Name of the Cognito Identity Provider |
| <a name="output_provider_type"></a> [provider\_type](#output\_provider\_type) | Type of the Cognito Identity Provider |
| <a name="output_user_pool_id"></a> [user\_pool\_id](#output\_user\_pool\_id) | ID of the Cognito User Pool |
