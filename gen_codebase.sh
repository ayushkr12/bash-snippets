generate_codebase() {
    if [ -z "$1" ]; then
        echo "Usage: generate_codebase <output_file>"
        return 1
    fi
    find . -type f ! -path "*/.git/*" ! -path "$output_file" -exec echo -e "\n\n{}\n\n" \; -exec cat {} \; > "$1"
    echo "Codebase written to $1"
}
