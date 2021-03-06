
# Environment Variables

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CONF_HOME=$HOME/zshfiles
export EDITOR="vim"
export PROSODIZER_SOUND_FILES="$HOME/College/Fourth_Year/Final_Year_Project/sounds"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export SSH_ASKPASS="/usr/bin/ksshaskpass"
export LESS='-RMi'
export EXT_IP="$(curl -s http://v4.ipv6-test.com/api/myip.php)"
export NPM_PACKAGES="$HOME/.npm-global/bin"
export USER_LOCAL_BIN_DIR="$HOME/.local/bin"
export USER_BIN_DIR="$HOME/bin"
export PATH="$USER_BIN_DIR:$NPM_PACKAGES:$USER_LOCAL_BIN_DIR:$PATH"

unset MANPATH
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
# export TERM=xterm-256color

if [ "$ZSH_THEME" = "powerlevel9k/powerlevel9k" ]; then
    # Lifted from: https://github.com/bhilburn/powerlevel9k
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator virtualenv)
fi
# End of Environment Variables
