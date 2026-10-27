# GRC Engineering Labs

Hands-on learning repository documenting my journey through the GRC Engineering Club labs, with a focus on Infrastructure as Code (IaC), cloud security, policy-as-code, compliance automation, and audit-ready evidence.

**Author:** Cesar Mora

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
| 2.4 | Terraform Modules for Compliance — GCP | In Progress |

Statuses will be updated as implementation, verification, evidence collection, and cleanup are completed.

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

**Objective:** Develop a reusable Terraform module for Google Cloud Storage with built-in compliance requirements.

**Current status:** In progress. Google Cloud project setup and billing configuration completed; Terraform module implementation pending.

## Repository Structure

The repository follows the GRC Engineering Club's lab organization.

- `terraform/primitives/` — Standalone Terraform configurations
- `terraform/modules/` — Reusable infrastructure modules
- `scripts/` — Shared automation scripts
- `evidence/` — Machine-readable compliance evidence organized by lab

Some directories will appear on GitHub only when they contain committed files.

## Security and Evidence Management

Terraform state files, potentially sensitive variable files, local provider installations, and binary plan files should not be committed to this public repository.

Evidence will be reviewed for sensitive information before publication.

Lab completion will be based on documented implementation, verification, required evidence, and cleanup—not simply the presence of Terraform source code.

## GRC Engineering Perspective

This repository approaches cloud infrastructure from two complementary perspectives:

**Engineering perspective:** How are security controls implemented, configured, and verified technically?

**GRC and audit perspective:** What requirements do these controls address, what evidence demonstrates implementation, and what gaps or limitations remain?

The goal is to connect compliance requirements with repeatable technical implementation and defensible audit evidence.

## References

- [GRC Engineering Club — Official Repository](https://github.com/GRCEngClub/cgep-labs)
- [Lab 2.3 — Building Your First Compliant Resource](https://github.com/GRCEngClub/cgep-labs/blob/main/guides/02_03_first_compliant_resource.md)
- [Lab 2.4 — Terraform Modules for Compliance](https://github.com/GRCEngClub/cgep-labs/blob/main/guides/02_04_terraform_modules_for_compliance.md)

