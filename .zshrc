PATH="$PATH":"$HOME/.dotfiles/scripts:$(go env GOPATH)/bin"


bindkey -s ^f "tmux-sessionizer\n"

GPG_TTY=$(tty)
export PATH=$PATH:$(go env GOPATH)/bin


