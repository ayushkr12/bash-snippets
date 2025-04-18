find . -type f -not -path "./.git/*" -exec echo -e "\n### {} ###" \; -exec cat {} \;
