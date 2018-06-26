if [[ `id -u` -eq 0 ]]; then
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    echo "**********************************************"
    echo -e "${RED}You are now loading ZSH as root!${NC}"
    echo -e "${RED}PLEASE BE CAREFUL${NC}"
    echo "**********************************************"
fi
# Oh My Zsh Configuration

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git-no-alias)

# User configuration

# User Files

source $HOME/zshfiles/env.zsh
source $HOME/.oh-my-zsh/oh-my-zsh.sh
source $ZSH_CONF_HOME/keybind.zsh
source $ZSH_CONF_HOME/completions.zsh
source $ZSH_CONF_HOME/functions.zsh
source $ZSH_CONF_HOME/aliases.zsh

systemctl --user import-environment PATH
# End of User Files
