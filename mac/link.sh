#/usr/bin/bash
DATE=$(date +"%Y%m%d%H%M")
here=$(pwd)

# mv ~/.vimrc $here/oldfiles/vimrc-$DATE
# ln -s $here/vimrc ~/.vimrc

mv ~/.vimrc /Users/$USER/git/dotfiles/mac/oldfiles/vimrc-$DATE
ln -s /Users/$USER/git/dotfiles/mac/vimrc ~/.vimrc

# rm ~/.oh-my-zsh/themes/agnoster.zsh-theme
# ln -s $here/agnoster.zsh-theme ~/.oh-my-zsh/themes/agnoster.zsh-theme

rm ~/.oh-my-zsh/themes/agnoster.zsh-theme
ln -s /Users/$USER/git/dotfiles/mac/agnoster.zsh-theme ~/.oh-my-zsh/themes/agnoster.zsh-theme

rm ~/Brewfile
ln -s /Users/$USER/git/dotfiles/mac/Brewfile ~/Brewfile

rm ~/.p10k.zsh
ln -s /Users/$USER/git/dotfiles/mac/p10k.zsh ~/.p10k.zsh
# rm ~/.zshrc
# ln -s $here/zshrc ~/.zshrc

rm ~/.zshrc
ln -s /Users/$USER/git/dotfiles/mac/zshrc ~/.zshrc

mkdir -p ~/.git-hooks
rm -f ~/.git-hooks/pre-commit
ln -s /Users/$USER/git/dotfiles/mac/git-hooks/pre-commit ~/.git-hooks/pre-commit

rm -f ~/Library/Preferences/com.googlecode.iterm2.plist
ln -s /Users/$USER/git/dotfiles/mac/iterm2-profile.plist ~/Library/Preferences/com.googlecode.iterm2.plist

rm ~/Library/Preferences/com.knollsoft.Rectangle.plist
ln -s /Users/$USER/git/dotfiles/mac/rectangle-config.json ~/Library/Preferences/com.knollsoft.Rectangle.plist

# touch ~/.Xmodmap
# echo 'clear Lock' >> ~/.Xmodmap
# echo 'keycode 66 = Escape NoSymbol Escape' >> ~/.Xmodmap

# xmodmap ~/.Xmodmap
