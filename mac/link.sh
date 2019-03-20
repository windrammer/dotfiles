#/usr/bin/bash
DATE=$(date +"%Y%m%d%H%M")
here=$(pwd)

mv ~/.vimrc $here/oldfiles/vimrc-$DATE
ln -s $here/vimrc ~/.vimrc

rm ~/.oh-my-zsh/themes/agnoster.zsh-theme
ln -s $here/agnoster.zsh-theme ~/.oh-my-zsh/themes/agnoster.zsh-theme

rm ~/.zshrc
ln -s $here/zshrc ~/.zshrc

# touch ~/.Xmodmap
# echo 'clear Lock' >> ~/.Xmodmap
# echo 'keycode 66 = Escape NoSymbol Escape' >> ~/.Xmodmap

# xmodmap ~/.Xmodmap
