# Oh My Zsh Configuration

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

# User Files

source $HOME/zsh_conf/keybind.zsh
source $HOME/zsh_conf/completions.zsh
source $HOME/zsh_conf/functions.zsh
source $HOME/zsh_conf/env.zsh
source $HOME/zsh_conf/aliases.zsh
source $HOME/.oh-my-zsh/oh-my-zsh.sh

# End of User Files
