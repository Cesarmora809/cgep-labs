# Lab 3.3 - Compliance Policies in Rego

These policies evaluate Google Cloud resources in Terraform plan JSON
before infrastructure deployment.

## SC-28 - Encryption at Rest
- File: sc28_encryption.rego
- Framework: NIST SP 800-53 SC-28
- Severity: High
- Requirement: Google Cloud Storage buckets must use CMEK.
- Remediation: Configure an encryption block with a customer-managed KMS key.

## AC-3 - Access Enforcement
- File: ac3_no_public.rego
- Framework: NIST SP 800-53 AC-3
- Severity: Critical
- Requirement: Enforce bucket public access protections and prevent publicly accessible SSH/RDP management ports.
- Remediation: Enforce uniform bucket-level access and public access prevention; restrict or remove unsafe firewall rules.

## CM-6 - Configuration Settings
- File: cm6_required_tags.rego
- Framework: NIST SP 800-53 CM-6
- Severity: Medium
- Requirement: Supported resources must have project, environment, managed_by, and compliance_scope labels.
- Remediation: Add missing required labels.

## Validation
- Eight automated unit tests.
- Four intentional violations detected in the original Terraform plan.
- All four addressed in the corrected plan.
- Final policy evaluations returned zero violations.
- No cloud resources deployed.

## Evidence
See evidence/lab-3-3/opa-test-results.json for automated unit test results.
