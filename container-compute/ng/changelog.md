
---

### 📄 `CHANGELOG.md`

```markdown
# Changelog

## [1.0.0] - 2025-07-18

### Added
- Provisioned EKS managed node group with configurable size and instance types.
- Created IAM role and attached required IAM policies using module-based resources.
- Provisioned Auto Scaling IAM policy with autoscaling, EKS describe, and EC2 describe permissions.
- Attached the autoscaling policy to the node group role.
- Deployed Cluster Autoscaler via Helm with configurable chart version and RBAC toggle.
