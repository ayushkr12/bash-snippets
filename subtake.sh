#!/bin/bash

# Usage: subtake <subs.txt> <threads> <output_file> [optional argument: output_file]

# Exit if custom nuclei templates path is not set in .bashrc
if [[ -z "$CUSTOM_NUCLEI_TEMPLATES_PATH" ]]; then
  echo "[error] Unable to find custom nuclei template PATH"
  exit 1
fi

CUSTOM_SUBDOMAIN_TAKEOVER_TEMPLATES_PATH="$CUSTOM_NUCLEI_TEMPLATES_PATH/subdomain_takeover_templates/"

subtake() {
  local subs_file="$1"
  local threads="$2"
  local output_file="$3"

  if [[ -n "$output_file" ]]; then
    nuclei -t "http/takeovers" -t "$CUSTOM_SUBDOMAIN_TAKEOVER_TEMPLATES_PATH" -l "$subs_file" -c "$threads" -o "$output_file"
  else
    nuclei -t "http/takeovers" -t "$CUSTOM_SUBDOMAIN_TAKEOVER_TEMPLATES_PATH" -l "$subs_file" -c "$threads"
  fi
}

# Ensure at least 2 arguments are provided
if [[ $# -lt 2 || $# -gt 3 ]]; then
    echo -e "\nUsage: $0 <subs.txt> <threads> [optional: <output_file>]\n"
    echo "Example:"
    echo -e "  $0 subs.txt 5        # Runs without output file"
    echo -e "  $0 subs.txt 5 result.out  # Runs and saves output to result.out\n"
    exit 1
fi

# Call function with provided arguments
subtake "$@"
