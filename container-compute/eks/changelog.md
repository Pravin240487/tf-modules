
---

### ✅ `CHANGELOG.md`

```markdown
# Changelog

## [1.0.0] - 2025-07-18

### Added

- EKS cluster with private and public endpoint toggle
- IAM roles for cluster and node group
- KMS key with policy for secrets encryption
- Managed Node Group with configurable instance types and auto-scaling
- EFS file system with mount targets in private subnets
- EFS CSI Driver Helm deployment with IRSA
- OIDC provider creation and annotation
- `aws-auth` config map updates with optional roles
- RBAC role and binding for EFS CSI controller
- Module variables and tagging support

### Fixed

- KMS policy formatting and role access consistency
- Helm chart upgrade support with `force_update` and `recreate_pods`

### Deprecated

- N/A

---

