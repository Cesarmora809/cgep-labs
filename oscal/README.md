# OSCAL Compliance Documentation

## Lab 6.1 - Introduction to OSCAL

This directory contains machine-readable compliance
documentation using NIST OSCAL 1.2.1.

## Component Definition

File: components/compliant-s3.json

Describes the compliant AWS S3 Terraform module located
at terraform/primitives/compliant-s3.

## Control Profile

File: profiles/cge-p-minimum.json

Selected NIST SP 800-53 Rev. 5 controls:

- SC-28: Protection of Information at Rest
- AC-3: Access Enforcement
- AU-3: Content of Audit Records
- CM-6: Configuration Settings

## Evidence Location

AWS S3 Evidence Vault:
cgep-lab-grc-evidence-vault-db012d6a

GitHub Actions Run: 45483910659

Evidence URI:
s3://cgep-lab-grc-evidence-vault-db012d6a/runs/45483910659/evidence-45483910659-f75aa5ad52596a8ec34cb14a577db05de7c37690.tar.gz

## Validation

Tool: Compliance Trestle v5.2.1

Component definition: VALID
Control profile: VALID
Evidence verification: CHAIN INTACT

Validation evidence:
evidence/lab-6-1/trestle-validate.txt

Schema validation and evidence integrity verification
do not independently establish full control effectiveness.
