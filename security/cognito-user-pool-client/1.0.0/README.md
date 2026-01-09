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
| [aws_cognito_user_pool_client.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token_validity"></a> [access\_token\_validity](#input\_access\_token\_validity) | Access token validity period in the specified units | `number` | `1` | no |
| <a name="input_allowed_oauth_flows"></a> [allowed\_oauth\_flows](#input\_allowed\_oauth\_flows) | List of allowed OAuth flows for this client | `list(string)` | <pre>[<br/>  "code"<br/>]</pre> | no |
| <a name="input_allowed_oauth_flows_user_pool_client"></a> [allowed\_oauth\_flows\_user\_pool\_client](#input\_allowed\_oauth\_flows\_user\_pool\_client) | Whether OAuth flows are enabled for this user pool client | `bool` | `true` | no |
| <a name="input_allowed_oauth_scopes"></a> [allowed\_oauth\_scopes](#input\_allowed\_oauth\_scopes) | List of allowed OAuth scopes for this client | `list(string)` | <pre>[<br/>  "email",<br/>  "openid",<br/>  "phone",<br/>  "profile",<br/>  "aws.cognito.signin.user.admin"<br/>]</pre> | no |
| <a name="input_app_client_name"></a> [app\_client\_name](#input\_app\_client\_name) | The name of the Cognito User Pool Client | `string` | n/a | yes |
| <a name="input_callbackUrls"></a> [callbackUrls](#input\_callbackUrls) | List of allowed callback URLs for OAuth flows | `list(string)` | n/a | yes |
| <a name="input_explicit_auth_flows"></a> [explicit\_auth\_flows](#input\_explicit\_auth\_flows) | List of authentication flows allowed for this client | `list(string)` | <pre>[<br/>  "ALLOW_REFRESH_TOKEN_AUTH",<br/>  "ALLOW_USER_SRP_AUTH"<br/>]</pre> | no |
| <a name="input_generate_secret"></a> [generate\_secret](#input\_generate\_secret) | Whether to generate a client secret. Set to false for public clients (mobile apps, SPAs) | `bool` | `true` | no |
| <a name="input_id_token_validity"></a> [id\_token\_validity](#input\_id\_token\_validity) | ID token validity period in the specified units | `number` | `1` | no |
| <a name="input_logout_urls"></a> [logout\_urls](#input\_logout\_urls) | List of allowed logout URLs for OAuth flows | `list(string)` | n/a | yes |
| <a name="input_prevent_user_existence_errors"></a> [prevent\_user\_existence\_errors](#input\_prevent\_user\_existence\_errors) | Choose which errors and responses are returned by Cognito APIs during authentication | `string` | `"ENABLED"` | no |
| <a name="input_refresh_token_validity"></a> [refresh\_token\_validity](#input\_refresh\_token\_validity) | Refresh token validity period in the specified units | `number` | `1` | no |
| <a name="input_supported_identity_providers"></a> [supported\_identity\_providers](#input\_supported\_identity\_providers) | List of supported identity providers for the client (COGNITO, and external providers) | `list(string)` | n/a | yes |
| <a name="input_token_validity_units"></a> [token\_validity\_units](#input\_token\_validity\_units) | Configuration for token validity time units (days, hours, minutes) | <pre>object({<br/>    refresh_token = string<br/>    access_token  = string<br/>    id_token      = string<br/>  })</pre> | <pre>{<br/>  "access_token": "days",<br/>  "id_token": "days",<br/>  "refresh_token": "days"<br/>}</pre> | no |
| <a name="input_user_pool_id"></a> [user\_pool\_id](#input\_user\_pool\_id) | The ID of the Cognito User Pool to associate with this client | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | Client ID of the Cognito User Pool Client |
| <a name="output_client_secret"></a> [client\_secret](#output\_client\_secret) | Client secret of the Cognito User Pool Client (only available when generate\_secret is true) |
| <a name="output_id"></a> [id](#output\_id) | ID of the Cognito User Pool Client |
| <a name="output_name"></a> [name](#output\_name) | Name of the Cognito User Pool Client |
| <a name="output_user_pool_id"></a> [user\_pool\_id](#output\_user\_pool\_id) | ID of the Cognito User Pool |
