#!/bin/bash
set -euo pipefail

function process_bucket() {
    local bucket="$1"
    echo "================================================================="
    echo "Bucket: $bucket"
    echo "================================================================="
    
    # Use process substitution to avoid subshell issues
    if ! aws s3 ls "s3://$bucket" --recursive > >(tee /dev/stderr | grep -q "^"); then
        echo "Empty or inaccessible bucket"
        return 0
    fi

    # Use GNU Awk specific features for better formatting
    aws s3 ls "s3://$bucket" --recursive 2>/dev/null | \
    gawk '
    BEGIN {
        CONVFMT = "%.2f"
        total_size = 0
        total_count = 0
        
        # Initialize arrays
        split("", files)        # for sorting by date
        split("", sizes)        # for file sizes
        split("", extensions)   # for extension counting
        split("", ext_sizes)    # for extension sizes
    }
    
    # Process each line
    {
        # Store full line for later
        files[NR] = $0
        sizes[NR] = $3
        total_size += $3
        total_count += 1
        
        # Process extension
        if (split($4, parts, ".") > 1) {
            ext = parts[length(parts)]
        } else {
            ext = "<no-extension>"
        }
        extensions[ext] += 1
        ext_sizes[ext] += $3
    }
    
    END {
        # Print summary
        printf "\nSummary:\n"
        printf "Total Size: %.2f MB\n", total_size/1024/1024
        printf "Object Count: %d\n", total_count
        
        if (total_count == 0) {
            print "\nNo files found."
            exit 0
        }
        
        # Print newest files
        printf "\nMost Recent Files:\n"
        asort(files, sorted_files, "@val_str_desc")
        for (i=1; i<=5 && i<=length(sorted_files); i++) {
            print sorted_files[i]
        }
        
        # Print largest files
        printf "\nLargest Files:\n"
        asort(sizes, sorted_sizes, "@val_num_desc")
        for (i=1; i<=5 && i<=length(sorted_sizes); i++) {
            for (j in sizes) {
                if (sizes[j] == sorted_sizes[i]) {
                    split(files[j], fields)
                    printf "%s\t%.2f MB\t%s\n", 
                           fields[1],
                           sorted_sizes[i]/1024/1024,
                           fields[4]
                    break
                }
            }
        }
        
        # Print extension summary
        printf "\nFile Types:\n"
        for (ext in extensions) {
            printf "%-20s %5d files  %8.2f MB\n",
                   ext,
                   extensions[ext],
                   ext_sizes[ext]/1024/1024
        }
    }
    ' || echo "Error processing bucket data"
    
    echo -e "\n"
}

# Main execution
echo "S3 Bucket Audit Report"
echo "Generated: $(date)"
echo "AWS CLI Version: $(aws --version)"
echo "AWK Version: $(awk --version | head -n1)"
echo

# Process each bucket
aws s3 ls | while read -r line; do
    bucket=$(echo "$line" | awk '{print $3}')
    process_bucket "$bucket"
done
