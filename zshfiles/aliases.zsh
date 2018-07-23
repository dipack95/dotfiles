# Aliases
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias ppu="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U"
alias pp3u="pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip3 install -U"
alias rmrecent='rm $HOME/.local/share/recently-used.xbel; touch $HOME/.local/share/recently-used.xbel'
alias spin-down='sudo shutdown now -h'
# End of Aliases
