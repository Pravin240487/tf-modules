# Introduction

Here's a well-structured document you can use for your Terraform Recommended Module. This includes a sample directory structure, versioning approach, and a summarized module creation workflow:

# Terraform Module Sample

## Module Directory Structure

```
stepfunction/
├── changelog.md         # Change history across versions
├── 1.0.0/              # Terraform module version 1.0.0
│   ├── example-dir/     # Sample usage for 1.0.0
│   ├── main.tf          # Main module logic
│   ├── outputs.tf       # Output definitions
│   ├── readme.md        # Documentation specific to this version
│   └── variables.tf     # Input variables
└── v2.0.0/              # (Reserved for future or in-progress version)
```

Each version is self-contained and versioned independently to ensure backward compatibility and traceability. Use semantic versioning (vMAJOR.MINOR.PATCH) to manage changes.

# Module Versioning Strategy

Terraform modules are versioned using Semantic Versioning:

**MAJOR** version changes include breaking changes.

**MINOR** updates add functionality in a backward-compatible manner.

**PATCH** versions fix bugs without affecting the module interface.

Example:

- 1.0.0 – Initial stable version.
- 1.1.0 – Added new output, backward-compatible.
- 2.0.0 – Introduced breaking change (e.g., input name change).

Use changelog.md to track changes across versions.

# Module Creation Workflow

## 1. Use Terraform Template for Reference
Instead of starting from scratch, use the existing Terraform template as a reference to:

- Structure the new module efficiently.
- Reuse proven patterns and configurations.
- Define flexible inputs and outputs for team-wide adoption.

## 2. Scope the Module
Keep modules focused and reusable:

**Encapsulation**: Group resources that always go together. 

Eg., An Lambda typically requires cloudwatch log group. So, they can be encapsulated into a single Lambda module.

**Volatility**: Separate stable resources from frequently changing ones.
- Eg., Stable: S3 bucket for storing logs (hardly changes)
- Volatile: CloudWatch alarms that often change thresholds or conditions

Keep S3 in one module and alarms in another.
Reduces risk of unintended changes to stable infra during updates.

## Build the MVP
Start small, functional, and extendable:

- Cover 80% of common use cases.
- Avoid supporting edge cases in early versions.
- Minimize use of complex conditionals.
- Only expose essential variables.
- Provide useful outputs — even if not used immediately — to aid chaining of modules.

## Documentation & Outputs
Each version should include:

- **readme.md** – Usage instructions, input/output documentation.
- **outputs.tf** – All useful outputs for downstream modules.

# Conclusion
Creating well-structured Terraform modules is key to building scalable, reusable, and maintainable infrastructure. By following best practices—such as referencing existing templates, focusing on clear encapsulation and separating volatile from stable components—we ensure that our modules are easy to use, secure, and resilient to change.

Start simple, design for flexibility, and evolve our modules with feedback and versioning. This approach accelerates adoption across teams, reduces duplication, and promotes consistent infrastructure standards.