# bash-snippets
Bash snippets i use during pentesting for making my life easier

```bash
complete -W "\$(gf -list)" gf
export PATH=$PATH:$HOME/go/bin

# Usage: cat rustscan.out | parallel -j 4 nmap_scan
nmap_scan() {
    local target="$1"
    local ip="${target%%:*}"  # Get the IP
    local port="${target##*:}" # Get the port
    echo "Scanning $ip on port $port..."
    nmap -sV -p "$port" "$ip" --script vulners
}

export -f nmap_scan

# Usage: resub test-FUZZ.example.com small
resub() {
    local subdomain="$1"
    local mode="$2"
    local wordlist="/home/eternal/Desktop/tools/wordlists/n0kovo_subdomains/n0kovo_subdomains_${mode}.txt"
    local results=""

    while read -r sub; do
        results+="${subdomain//FUZZ/$sub}\n"
    done < "$wordlist"

    echo -e "$results"
}

```
