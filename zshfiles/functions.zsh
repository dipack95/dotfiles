# make a backup of a file
# https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc
function bk() {
    cp -a "$1" "${1}_$(date --iso-8601=seconds)"
}

# print a separator banner, as wide as the terminal
function hr {
    print ${(l:COLUMNS::=:)}
}

# get public ip
function myip {
    local api
    case "$1" in
        "-4")
            api="http://v4.ipv6-test.com/api/myip.php"
            ;;
        "-6")
            api="http://v6.ipv6-test.com/api/myip.php"
            ;;
        *)
            api="http://ipv6-test.com/api/myip.php"
            ;;
    esac
    curl -s "$api"
    echo # Newline.
}

# Create short urls via http://goo.gl using curl(1).
# Contributed back to grml zshrc
# API reference: https://code.google.com/apis/urlshortener/
function zurl {
    if [[ -z $1 ]]; then
        print "USAGE: $0 <URL>"
        return 1
    fi

    local url=$1
    local api="https://www.googleapis.com/urlshortener/v1/url"
    local data

    # Prepend "http://" to given URL where necessary for later output.
    if [[ $url != http(s|)://* ]]; then
        url="http://$url"
    fi
    local json="{\"longUrl\": \"$url\"}"

    data=$(curl --silent -H "Content-Type: application/json" -d $json $api)
    # Match against a regex and print it
    if [[ $data =~ '"id": "(http://goo.gl/[[:alnum:]]+)"' ]]; then
        print $match
    fi
}

function dot_progress() {
    # Fancy progress function from Landley's Aboriginal Linux.
    # Useful for long rm, tar and such.
    # Usage:
    #     rm -rfv /foo | dot_progress
    local i='0'
    local line=''z

    while read line; do
        i="$((i+1))"
        if [ "${i}" = '25' ]; then
            printf '.'
            i='0'
        fi
    done
    printf '\n'
}

function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1   | dot_progress ;;
            *.tar.gz)    tar xvzf $1   | dot_progress ;;
            *.bz2)       bunzip2 $1    | dot_progress ;;
            *.rar)       unrar x $1    | dot_progress ;;
            *.gz)        gunzip $1     | dot_progress ;;
            *.tar)       tar xvf $1    | dot_progress ;;
            *.tbz2)      tar xvjf $1   | dot_progress ;;
            *.tgz)       tar xvzf $1   | dot_progress ;;
            *.zip)       unzip $1      | dot_progress ;;
            *.Z)         uncompress $1 | dot_progress ;;
            *.7z)        7z x $1       | dot_progress ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function scan_localnet() {
    local interface
    if [ -n "$1" ] ; then
        interface="$1"
    else
        interface="wlan0"
    fi
    echo "Scanning local network for all hosts"
    echo "Requesting superuser access"
    sudo arp-scan --interface "$interface" --localnet
}
