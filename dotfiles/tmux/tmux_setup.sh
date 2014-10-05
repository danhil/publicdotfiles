cp -f $HOME/dotfiles/tmux/tmux-main.conf ~/.tmux.conf

platform=$(uname)

cat $HOME/dotfiles/tmux/tmux-linux.conf >> ~/.tmux.conf

