# GRC Engineering Labs

Hands-on learning repository documenting my journey through the GRC Engineering Club labs, with a focus on Infrastructure as Code (IaC), cloud security, policy-as-code, compliance automation, and audit-ready evidence.

## Project Objectives

- Translate GRC and security requirements into technical implementations.
- Build and validate cloud security controls using Terraform.
- Develop reusable Infrastructure-as-Code configurations.
- Understand how automation strengthens compliance and control effectiveness.
- Generate and preserve machine-readable compliance evidence.
- Document technical challenges, troubleshooting, and lessons learned.

## Technologies

| Technology | Purpose |
|---|---|
| Git and Git Bash | Version control and command-line workflows |
| GitHub | Source code management and documentation |
| Terraform | Infrastructure as Code |
| AWS CLI | AWS cloud resource management |
| Google Cloud CLI | Google Cloud resource management |
| Open Policy Agent (OPA) | Policy-as-code |
| Cosign | Artifact signing and verification |

## Lab Progress

| Lab | Project | Status |
|---|---|---|
| 2.3 | Building Your First Compliant Resource — AWS S3 | Code recovered; evidence verification pending |
| 2.4 | Terraform Modules for Compliance — GCP | Deployed; final validation and cleanup pending |

## Lab Documentation

### Lab 2.3 — Building Your First Compliant Resource

[View Lab 2.3 Terraform files](terraform/primitives/compliant-s3/)

**Cloud Platform:** Amazon Web Services (AWS)

**Objective:** Configure AWS S3 resources using Terraform with security controls aligned to NIST SP 800-53.

**Controls covered:**

- SC-28 — Protection of Information at Rest
- AC-3 — Access Enforcement
- AU-3 — Content of Audit Records
- AU-6 — Audit Record Review, Analysis, and Reporting
- CM-6 — Configuration Settings

**Current status:** Terraform source code recovered and published. Final evidence verification remains pending.

### Lab 2.4 — Terraform Modules for Compliance

**Cloud Platform:** Google Cloud Platform (GCP)

**Objective:** Build and deploy a reusable Terraform module that enforces security and compliance requirements for Google Cloud Storage.

**Implementation:**

- Developed a reusable Terraform module for compliant Google Cloud Storage.
- Configured customer-managed encryption keys using Google Cloud KMS.
- Established a 90-day cryptographic key rotation period.
- Enforced public access prevention and uniform bucket-level access.
- Enabled object versioning and a 30-day development retention policy.
- Implemented required resource labels.
- Added input validation requiring at least 365 days of retention for production.
- Created separate development, production, and negative-test consumers.

**Deployment results:**

- Successfully initialized the Terraform configuration.
- Generated and applied a Terraform deployment plan.
- Provisioned four Google Cloud resources: KMS keyring, cryptographic key, KMS IAM binding, and Cloud Storage bucket.
- Generated a machine-readable compliance attestation.

**Security controls addressed:**

- AC-3 — Access Enforcement
- SC-12 — Cryptographic Key Establishment and Management
- SC-13 — Cryptographic Protection
- SC-28 — Protection of Information at Rest
- AU-11 — Audit Record Retention
- CM-6 — Configuration Settings

**Source code:**

- [Reusable GCS module](terraform/modules/compliant-gcs-bucket/)
- [Development configuration](terraform/primitives/compliant-gcs/)
- [Production configuration](terraform/primitives/compliant-gcs-prod/)
- [Negative compliance test](terraform/primitives/compliant-gcs-negative/)

**Compliance evidence:**

- [Lab 2.4 evidence directory](evidence/lab-2-4/)

**Current status:** Development deployment successful. Final live-resource verification, negative testing, evidence review, repository publication, and infrastructure cleanup remain to be completed.

## Repository Structure

The repository follows the GRC Engineering Club's lab organization.

- `terraform/primitives/` — Standalone Terraform configurations and module consumers
- `terraform/modules/` — Reusable infrastructure modules
- `scripts/` — Shared automation scripts
- `evidence/` — Machine-readable compliance evidence organized by lab

Some directories will appear on GitHub only when they contain committed files.

## Security and Evidence Management

Terraform state files, potentially sensitive variable files, local provider installations, and binary plan files are excluded from public version control.

Evidence is reviewed for sensitive information before publication.

Lab completion is based on documented implementation, verification, required evidence, and cleanup—not simply the presence of Terraform source code.

## GRC Engineering Perspective

This repository approaches cloud infrastructure from two complementary perspectives:

**Engineering perspective:** How are security controls implemented, configured, and verified technically?

**GRC and audit perspective:** What requirements do these controls address, what evidence demonstrates implementation, and what gaps or limitations remain?

The goal is to connect compliance requirements with repeatable technical implementation and defensible audit evidence.

## References

- [GRC Engineering Club — Official Repository](https://github.com/GRCEngClub/cgep-labs)
- [Lab 2.3 — Building Your First Compliant Resource](https://github.com/GRCEngClub/cgep-labs/blob/main/guides/02_03_first_compliant_resource.md)
- [Lab 2.4 — Terraform Modules for Compliance](https://github.com/GRCEngClub/cgep-labs/blob/main/guides/02_04_terraform_modules_for_compliance.md)
