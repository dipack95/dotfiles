# Path to your oh-my-zsh installation.
export ZSH=/home/dipack/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ys"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
source $ZSH/oh-my-zsh.sh
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

# Key Bindings

# Who doesn't want home and end to work?
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

# End of Key Bindings

# Environment Variables
export EDITOR="vim"
## added by Anaconda3 2.5.0 installer
export PATH="/home/dipack/anaconda3/bin:$PATH"

# End of Environment Variables

# Aliases
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias uu="sudo apt-get update && sudo apt-get upgrade"
alias ppu="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U"
alias pp3u="pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip3 install -U"
# End of Aliases	

# Kill and Killall completion
zstyle ':completion:*:processes' command 'ps -ax'
zstyle ':completion:*:processes-names' command 'ps -aeo comm='
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:killall:*:processes-names' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:killall:*' menu yes select


# make a backup of a file
# https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc
bk() {
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
