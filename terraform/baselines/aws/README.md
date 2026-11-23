# Lab 5.2 — AWS Security Services Baseline

**Status:** Deployment, verification, evidence export, and cleanup completed; required non-empty findings evidence not achieved.

## Objective
Deploy AWS-native security monitoring with Terraform, verify CloudTrail and Security Hub, export machine-readable evidence, and tear down the temporary resources to limit cost.

## Services and NIST SP 800-53 mappings

| Service | Controls | Deployment |
|---|---|---|
| AWS CloudTrail | AU-2 (Event Logging), AU-12 (Audit Record Generation), AU-10 (Non-Repudiation) | Deployed, verified, destroyed |
| AWS Security Hub | RA-5 (Vulnerability Monitoring and Scanning), SI-4 (System Monitoring) | Deployed, verified, destroyed |
| AWS Config | CM-2 (Baseline Configuration), CM-6 (Configuration Settings), CM-8 (System Component Inventory) | Optional; not deployed |

These are the control mappings specified in the official lab guide. Deployment alone does not establish full control compliance.

## Implementation and verification
- Terraform provisioned a multi-region CloudTrail trail with log-file validation and an S3 logging bucket.
- CloudTrail verification returned `IsLogging: true`.
- Security Hub returned its hub ARN and subscribed to NIST 800-53 Rev. 5 and AWS Foundational Security Best Practices.
- Evidence captured: [security-hub-findings.json](../../../evidence/lab-5-2/security-hub-findings.json).
- **Evidence limitation:** The captured file contains `{"Findings":[]}`. This is a valid JSON response but **does not meet the guide's requirement to demonstrate at least one finding**. An empty finding result does not prove there are no vulnerabilities or configuration gaps.
- During a second deployment on November 23, 2026, `aws securityhub get-enabled-standards` reported `INCOMPLETE` and `NO_AVAILABLE_CONFIGURATION_RECORDER` for CIS AWS Foundations Benchmark, AWS Foundational Security Best Practices, and NIST 800-53 Rev. 5. No findings were returned during the capture.
- AWS Config was not deployed because the official guide explicitly makes it optional. Without an available Config recorder, these Security Hub standards could not complete their checks in this run.

## GitHub and cleanup
- Implementation and evidence committed as `3fdb52f` on branch `lab-4-3-log-versioning`.
- Ran `terraform destroy -auto-approve` after the evidence was committed.
- Re-deployed the nine Lab 5.2 resources to attempt another findings capture; the findings result remained empty because the enabled standards were `INCOMPLETE`.
- Following the retry, ran `terraform destroy -auto-approve` again and Terraform reported `Destroy complete! Resources: 9 destroyed.`
- The Terraform-managed Lab 5.2 baseline was removed. This does not verify billing or unrelated resources elsewhere in the AWS account.

## GRC and audit application
CloudTrail supports audit activity records; Security Hub centralizes security control findings; AWS Config (if deployed) can record configuration history. The exported JSON can support evidence collection and remediation, but reviewers must validate its contents, dates, scope, and control relevance.

**Official guide:** https://github.com/GRCEngClub/cgep-labs/blob/main/guides/05_02_aws_security_services.md
