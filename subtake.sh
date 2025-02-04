# Usage: subtake <subs.txt> <threads> <output_file> [optional argument: output_file]

# exit if custom nuclei templates path is not in environment variables or bash.rc
if [[ $(echo $CUSTOM_NUCLEI_TEMPLATES_PATH) == "" ]]; then
  echo -e "[ERROR] unable to find custom nuclei template PATH"
  exit 1
fi

CUSTOM_SUBDOMAIN_TAKEOVER_TEMPLATES_PATH="$CUSTOM_NUCLEI_TEMPLATES_PATH"/subdomain_takeover_templates/

subtake() {
  local subs_file=$1
  local threads=$2
  local output_file="$3"

  if [[ -n $output_file ]]; then
    nuclei -t "http/takeovers" -t "$CUSTOM_SUBDOMAIN_TAKEOVER_TEMPLATES_PATH" -l "$subs_file" -c "$threads" 
  else
    nuclei -t "http/takeovers" -t "$CUSTOM_SUBDOMAIN_TAKEOVER_TEMPLATES_PATH" -l "$subs_file" -c "$threads" -o "$output_file"
  fi
}

if [[ $# -ne 2 ]]; then
    echo -e "\nUsage: $0 <subs.txt> <threads> <output_file> [optional argument: <output_file>]\n"
    echo "Example:"
    echo -e "  $0 subs.txt 5 subtake.out\n"
    exit 0
fi
