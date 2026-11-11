# Lab 4.4 — Evidence Management and Chain of Custody

## Objective
Generate, cryptographically sign, preserve, and independently verify compliance evidence using GitHub Actions, Cosign, and AWS S3 Object Lock.

## Chain-of-Custody Properties

| Property | Evidence Artifact | Verification |
|---|---|---|
| Authenticity | .sig.bundle | Cosign verifies the signature and GitHub OIDC issuer. |
| Integrity | .sha256 | SHA-256 comparison confirms the evidence bundle has not changed. |
| Timeliness | Cosign signature bundle and Rekor record | Sigstore provides a verifiable signing record and timestamp. |
| Preservation | AWS S3 Object Lock | S3 object retention confirms the evidence remains protected. |

## Verification Results

GitHub Actions Run ID: 43110568117

Evidence Vault: cgep-lab-grc-evidence-vault-db012d6a

Verification Results:
- SHA-256 integrity check: PASS
- Cosign signature verification: Verified OK
- S3 retention check: PASS
- Chain-of-custody result: CHAIN INTACT

## Tamper Test

A copy of the evidence bundle was downloaded from S3.

The local copy was modified by appending "junk" to the file.

Modified SHA-256:
94dd277df54243f5a3e8e0850d5170a7e9f5eb8123c6e7e48bd733586a287eb5

The modified copy demonstrates how changing evidence changes its cryptographic hash.

The original signed evidence remained in AWS S3.
