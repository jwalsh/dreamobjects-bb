#!/bin/bash
set -euo pipefail

BUCKET="splash-2024"
ACCOUNT=$(aws sts get-caller-identity | jq -r .Account)

echo "=== Complete Bucket Security Audit ==="
echo "Bucket: $BUCKET"
echo "Date: $(date)"
echo

echo "1. Public Access Settings:"
aws s3api get-public-access-block --bucket $BUCKET || echo "No public access block configured!"

echo -e "\n2. Bucket Policy:"
aws s3api get-bucket-policy --bucket $BUCKET 2>/dev/null || echo "No bucket policy configured"

echo -e "\n3. Encryption Configuration:"
aws s3api get-bucket-encryption --bucket $BUCKET 2>/dev/null || echo "Default encryption not configured!"

echo -e "\n4. Versioning Status:"
aws s3api get-bucket-versioning --bucket $BUCKET

echo -e "\n5. Lifecycle Rules:"
aws s3api get-bucket-lifecycle-configuration --bucket $BUCKET 2>/dev/null || echo "No lifecycle rules configured"

echo -e "\n6. Cross Region Replication:"
aws s3api get-bucket-replication --bucket $BUCKET 2>/dev/null || echo "No replication configured"

echo -e "\n7. Object Lock Configuration:"
aws s3api get-object-lock-configuration --bucket $BUCKET 2>/dev/null || echo "No object lock configured"

echo -e "\n8. Access Points:"
aws s3control list-access-points --account-id $ACCOUNT --bucket $BUCKET 2>/dev/null || echo "No access points configured"

echo -e "\n9. Bucket Logging:"
aws s3api get-bucket-logging --bucket $BUCKET
