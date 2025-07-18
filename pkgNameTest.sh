#!/usr/bin/env bash

#
# Validates package names in archPkgsList.md against the Nixpkgs repository.
# Prints only packages not found in nixpkgs, and suggests the closest matching name.
#

set -euo pipefail

input_file="archPkgsList.md"

# Check dependencies
for cmd in jq python3 nix-env; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "Error: '$cmd' is required but not installed." >&2
        exit 1
    fi
done

# Check if input file is readable
if [[ ! -r "$input_file" ]]; then
    printf "Error: File not found or not readable: %s\n" "$input_file" >&2
    exit 1
fi

# Fetch all nixpkgs attribute names using nix-env, suppress warnings
mapfile -t all_pkg_names < <(nix-env -qaP --json 2>/dev/null | jq -r 'keys[]')

# Build associative arrays:
# - nixpkgs_map: key=basename of attribute, value=1 for existence check
# - nixpkgs_fullname_map: key=basename, value=full attribute name for suggestions
declare -A nixpkgs_map
declare -A nixpkgs_fullname_map

for full_name in "${all_pkg_names[@]}"; do
    base_name="${full_name##*.}"
    nixpkgs_map["$base_name"]=1
    nixpkgs_fullname_map["$base_name"]="$full_name"
done

# Function to suggest closest match using Python on basenames
suggest_closest_match() {
    local target="$1"
    printf "%s\n" "${!nixpkgs_map[@]}" | python3 -c "
import sys
from difflib import get_close_matches
target = sys.argv[1]
pkgs = [line.strip() for line in sys.stdin if line.strip()]
match = get_close_matches(target, pkgs, n=1, cutoff=0.4)
print(match[0] if match else 'no close match')
" -- "$target"
}

# Process the package list
while IFS= read -r line; do
    # Remove inline comments and trim whitespace
    line="${line%%#*}"
    pkg_name="$(echo "$line" | xargs)"

    # Skip empty lines
    [[ -z "$pkg_name" ]] && continue

    # Check if package basename is found
    if [[ -z "${nixpkgs_map[$pkg_name]+found}" ]]; then
        suggestion="$(suggest_closest_match "$pkg_name")"
        if [[ "$suggestion" != "no close match" ]]; then
            suggestion_full="${nixpkgs_fullname_map[$suggestion]}"
        else
            suggestion_full="$suggestion"
        fi
        printf "%s (not found, maybe: %s)\n" "$pkg_name" "$suggestion_full"
    fi
done < "$input_file"
