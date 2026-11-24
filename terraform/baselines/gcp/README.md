# Lab 5.4 — GCP Security Services Baseline

## Objective

Deploy preventive security controls, keyless authentication, and Data Access audit logging in Google Cloud using Terraform.

## Organization Policies

The following constraints were deployed and enforced:

| Constraint | Purpose |
|---|---|
| storage.uniformBucketLevelAccess | Require uniform bucket-level access for Cloud Storage |
| iam.disableServiceAccountKeyCreation | Prevent creation of service-account keys |
| compute.requireOsLogin | Require OS Login for supported Compute Engine instances |

## Workload Identity Federation

Configured GitHub Actions authentication through Google Cloud Workload Identity Federation using OIDC.

The provider trusts the repository `Cesarmora809/cgep-labs` and allows authentication through a read-only service account without downloading a service-account JSON key.

## Data Access Audit Logging

Data Access audit logs are disabled by default for most Google Cloud services and must be explicitly configured.

This lab enables DATA_READ, DATA_WRITE, and ADMIN_READ audit logging for:

- Cloud Storage
- Cloud KMS
- IAM

## Validation

Terraform successfully deployed all 11 resources.

The negative test confirmed that service-account key creation was blocked with FAILED_PRECONDITION by the iam.disableServiceAccountKeyCreation constraint.

The three Organization Policies were listed as SET, and the Workload Identity Federation pool was confirmed ACTIVE.

## Audit Evidence

The file `evidence/lab-5-4/iam-policy.json` contains the exported Data Access audit logging configuration.
