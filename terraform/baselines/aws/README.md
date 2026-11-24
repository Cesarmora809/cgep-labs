# Lab 5.2 — AWS Security Services Baseline

**Status:** **Completed** on November 23, 2026 — Terraform deployment and verification, AWS Config troubleshooting, five Security Hub findings published to `main` through [PR #17](https://github.com/Cesarmora809/cgep-labs/pull/17), and AWS resource cleanup verified.

## Objective

Deploy an AWS-native security monitoring baseline, verify event logging and Security Hub control evaluations, and collect machine-readable evidence for GRC and audit use.

Official guide: [GRC Engineering Club Lab 5.2](https://github.com/GRCEngClub/cgep-labs/blob/main/guides/05_02_aws_security_services.md).

## Architecture and control mapping

| Component | Implementation | NIST SP 800-53 Rev. 5 controls |
|---|---|---|
| AWS CloudTrail | Multi-region management-event trail; S3 logs; log-file validation | AU-2, AU-12, AU-10 |
| AWS Security Hub CSPM | NIST 800-53 Rev. 5 and AWS FSBP subscriptions; default CIS benchmark also observed | RA-5, SI-4 |
| AWS Config | Manually provisioned service-linked role, recorder, and S3 delivery channel to support Security Hub security checks | CM-2, CM-6, CM-8 |

These mappings follow the official exercise and demonstrate supporting technical capabilities—not a determination that the AWS account or an organization is compliant.

## Terraform-managed baseline

The files in this directory follow the official walkthrough:

- `main.tf`: AWS provider, common tags, account ID lookup, random bucket suffix.
- `cloudtrail.tf`: multi-region CloudTrail with log validation and S3 logging infrastructure.
- `security_hub.tf`: Security Hub account and NIST 800-53/FSBP subscriptions.
- `variables.tf`: region default (`us-east-1`).
- `outputs.tf`: CloudTrail trail/bucket and Security Hub account outputs.

A successful apply reported **9 added, 0 changed, 0 destroyed**. Verification returned `IsLogging: true` and the Security Hub ARN.

## Root cause and remediation: NO_AVAILABLE_CONFIGURATION_RECORDER

The initial deployments enabled Security Hub but produced no findings. All subscribed standards reported `INCOMPLETE` with `NO_AVAILABLE_CONFIGURATION_RECORDER`. Waiting did not resolve the issue.

Read-only checks confirmed:
1. `describe-configuration-recorders` returned `[]`.
2. `describe-configuration-recorder-status` returned `[]`.
3. `describe-delivery-channels` returned `[]`.
4. `organizations describe-organization` returned `AWSOrganizationsNotInUseException`, ruling out an Organizations SCP in this standalone AWS account.
5. IAM policy simulation allowed the Config setup operations.

**Additional prerequisite applied beyond the guide's provided Terraform:** Using the IAM user `grc-terraform-lab` and region `us-east-1`, the following AWS Config components were configured manually:

1. Created service-linked role `AWSServiceRoleForConfig` for `config.amazonaws.com`.
2. Created dedicated S3 delivery bucket and applied an account-scoped service bucket policy for ACL checking, listing, and delivery to `AWSLogs/<account-id>/Config/*`.
3. Created configuration recorder `default` using the service-linked role and `allSupported=true,includeGlobalResourceTypes=true`.
4. Created delivery channel `default` pointing at the dedicated bucket.
5. Started the configuration recorder and verified `recording: true`, `lastStatus: SUCCESS`.

After starting Config, Security Hub standards changed from `INCOMPLETE` to `READY`. This is the observed remediation for this account, not a claim that the guide requires Config in every account.

## Verified results and findings

- Terraform deployed **9** baseline resources.
- AWS Config: `recording: true`, `lastStatus: SUCCESS`.
- CloudTrail: `IsLogging: true`.
- Security Hub: hub ARN returned successfully.
- Standards: NIST 800-53 Rev. 5, AWS FSBP, and CIS AWS Foundations all `READY`.
- `aws securityhub get-findings --max-results 50` returned **5 findings** in the observed batch.
- The locally captured `security-hub-findings.json` was **approximately 25 KB**, non-empty, and subsequently published to GitHub.
- The CLI summary showed an S3 MFA Delete finding with compliance `FAILED` and S3 public-access findings with compliance `PASSED`.

**Evidence:** [`evidence/lab-5-2/security-hub-findings.json`](../../../evidence/lab-5-2/security-hub-findings.json) contains the actual CLI export of five findings and is published on `main` following the merge of PR #17. An earlier branch contains an obsolete `{"Findings":[]}` and must not be mistaken for the final evidence. **Public repository note:** Findings contain AWS account/resource identifiers; assess the exposure and redact if required by your disclosure policy.

Representative capture command (from `terraform/baselines/aws`):

```bash
mkdir -p ../../../evidence/lab-5-2
aws securityhub get-findings --region us-east-1 --profile default --max-results 50 \
  > ../../../evidence/lab-5-2/security-hub-findings.json
```

## Audit and operational considerations

- A `FAILED` finding is legitimate evidence of a control gap; it does not mean this lab failed.
- `READY` means the standards are ready for evaluation, not that all controls passed.
- Evidence must retain source, timestamps, relevant findings, and scope, and should be reviewed before public publication.
- No additional Lab 5.2 Rego policies or Bash scripts are required by the official guide. Existing policy-as-code and evidence scripts from earlier labs remain untouched.
- The manually configured AWS Config infrastructure is **outside the Terraform state**; `terraform destroy` does **not** remove those resources.

## Cleanup — completed and verified

Following the successful evidence publication, AWS cleanup was executed and independently verified using the AWS CLI in account `409369915399`, region `us-east-1`:

| Resource or verification | Observed result |
|---|---|
| Terraform-managed CloudTrail, S3, Security Hub, and standard subscriptions | `Destroy complete! Resources: 9 destroyed.` |
| Terraform state | Empty (`terraform state list` produced no managed resources) |
| CloudTrail `cgep-lab-mgmt` | `describe-trails --trail-name-list cgep-lab-mgmt` returned `[]` |
| Security Hub CSPM subscription | `describe-hub` returned `InvalidAccessException: Account ... is not subscribed to AWS Security Hub CSPM` |
| AWS Config recorder | `ConfigurationRecorders: []` |
| AWS Config delivery channel | `DeliveryChannels: []` |
| Dedicated AWS Config S3 bucket | AWS CLI reported `remove_bucket` for `cgep-lab-5-2-config-409369915399-us-east-1` |
| AWS Config service-linked IAM role | `iam get-role --role-name AWSServiceRoleForConfig` returned `NoSuchEntity` |

The recorder was stopped before its delivery channel and configuration recorder were deleted. The manually created AWS Config S3 bucket and IAM role were removed separately because they were never managed by the Terraform baseline. The service-linked role deletion request was accepted and later confirmed by the role's absence, although the deletion-task status API had temporarily returned `NoSuchEntity`.

**Scope:** These checks establish removal of the Lab 5.2 resources listed above. They do not verify the full AWS account's billing status or unrelated infrastructure.

