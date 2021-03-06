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

function activate_python_virtualenv() {
    local env_name="$1";
    local venv_home="$HOME/py-venv";
    if [ ! -d "$venv_home" ]; then
        echo "Looking for python virtual environments in $venv_home, but it does not exist!";
        return 255;
    elif [ ! -d "$venv_home/$env_name" ] || [ ! -f "$venv_home/$env_name/bin/activate" ]; then
        echo "$venv_home/$env_name has not been setup correctly using 'virtualenv'!";
        return 255;
    elif source "$venv_home/$env_name/bin/activate"; then
        echo "Successfully activated $env_name python virtual env!";
        echo "Type 'deactivate' to exit the virtual environment!";
    else
        echo "Failed to activate $env_name!";
        return $?;
    fi
}
