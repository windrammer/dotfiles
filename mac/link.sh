#/usr/bin/bash
DATE=$(date +"%Y%m%d%H%M")
here=$(pwd)

# mv ~/.vimrc $here/oldfiles/vimrc-$DATE
# ln -s $here/vimrc ~/.vimrc

mv ~/.vimrc /Users/davtol/git/dotfiles/mac/oldfiles/vimrc-$DATE
ln -s /Users/davtol/git/dotfiles/mac/vimrc ~/.vimrc

# rm ~/.oh-my-zsh/themes/agnoster.zsh-theme
# ln -s $here/agnoster.zsh-theme ~/.oh-my-zsh/themes/agnoster.zsh-theme

# rm ~/.oh-my-zsh/themes/agnoster.zsh-theme
# ln -s /Users/davtol/git/dotfiles/mac/agnoster.zsh-theme ~/.oh-my-zsh/themes/agnoster.zsh-theme

rm ~/.p10k.zsh
ln -s /Users/davtol/git/dotfiles/mac/p10k.zsh ~/.p10k.zsh
# rm ~/.zshrc
# ln -s $here/zshrc ~/.zshrc

rm ~/.zshrc
ln -s /Users/davtol/git/dotfiles/mac/zshrc ~/.zshrc

# touch ~/.Xmodmap
# echo 'clear Lock' >> ~/.Xmodmap
# echo 'keycode 66 = Escape NoSymbol Escape' >> ~/.Xmodmap

# xmodmap ~/.Xmodmap
