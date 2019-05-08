#/usr/bin/bash
DATE=$(date +"%Y%m%d%H%M")
here=$(pwd)

# mv ~/.vimrc $here/oldfiles/vimrc-$DATE
# ln -s $here/vimrc ~/.vimrc

mv ~/.vimrc /Users/david.tollman/dotfiles/mac/oldfiles/vimrc-$DATE
ln -s /Users/david.tollman/dotfiles/mac/vimrc ~/.vimrc

# rm ~/.oh-my-zsh/themes/agnoster.zsh-theme
# ln -s $here/agnoster.zsh-theme ~/.oh-my-zsh/themes/agnoster.zsh-theme

rm ~/.oh-my-zsh/themes/agnoster.zsh-theme
ln -s /Users/david.tollman/dotfiles/mac/agnoster.zsh-theme ~/.oh-my-zsh/themes/agnoster.zsh-theme

# rm ~/.zshrc
# ln -s $here/zshrc ~/.zshrc

rm ~/.zshrc
ln -s /Users/david.tollman/dotfiles/mac/zshrc ~/.zshrc

# touch ~/.Xmodmap
# echo 'clear Lock' >> ~/.Xmodmap
# echo 'keycode 66 = Escape NoSymbol Escape' >> ~/.Xmodmap

# xmodmap ~/.Xmodmap
