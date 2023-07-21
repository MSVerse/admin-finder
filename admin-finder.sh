#!/bin/bash

# color
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# admin panel
find_admin_panel() {
    target="$1"
    wordlist="$2"

    if [ -z "$target" ] || [ -z "$wordlist" ]; then
        echo -e "${GREEN}[${RED}+${GREEN}]${NC} ./admin-finder.sh example.com wordlist.txt ${NC}"
        return
    fi

    if ! [ -f "$wordlist" ]; then
        echo -e "${RED}[+] Error: File wordlist '$wordlist' tidak ditemukan.${NC}"
        return
    fi

    echo -e "${GREEN}[+] Mencari admin panel pada $target${NC}"

    while read -r path; do
        url="$target$path"
        status_code=$(curl -o /dev/null --silent --head --write-out '%{http_code}' "$url")
        if [ "$status_code" -eq 200 ]; then
            echo -e "${GREEN}[${RED}+${GREEN}]${NC} $url => ${GREEN}OK${NC}"
        else
            echo -e "${GREEN}[${RED}+${GREEN}]${NC} $url => ${RED}ERROR${NC}"
        fi
    done < "$wordlist"
}

# argumen
find_admin_panel "$1" "$2"
