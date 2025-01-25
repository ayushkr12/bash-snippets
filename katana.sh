# Usage: katana_crawl <hosts_file> <output_file> <crawl_depth> <max_duration>

katana_crawl() {
    local filtered_live_hosts_file=$1
    local output_file=$2
    local depth_to_crawl=$3
    local max_duration_to_crawl=$4
    scan_time=$(date +"%Y-%m-%d-%H-%m-%S")

    mkdir -p ".cache/$scan_time"

    katana -list "$filtered_live_hosts_file" -ps -o ".cache/$scan_time/passive_crawled.txt"
    katana -list "$filtered_live_hosts_file" -d "$depth_to_crawl" -jc -kf -fx -xhr -aff -jsl -c 50 \
                -o ".cache/$scan_time/active_crawled.txt" -ct "$max_duration_to_crawl"
    
    cat ".cache/$scan_time/passive_crawled.txt" ".cache/$scan_time/active_crawled.txt" | sort -u >> "$output_file"
}
if [[ $# -ne 4 ]]; then
    echo -e "\nUsage: $0 <hosts_file> <output_file> <crawl_depth> <crawl_duration>\n"
    echo "Example:"
    echo -e "  ./katana.sh livehosts.txt 5 15m\n"
    exit 0
fi
