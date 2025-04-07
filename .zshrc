PATH="$PATH":"$HOME/.dotfiles/scripts:$(go env GOPATH)/bin"

bindkey -s ^f "tmux-sessionizer\n"

export GPG_TTY=$(tty)
export PATH=$PATH:$(go env GOPATH)/bin
