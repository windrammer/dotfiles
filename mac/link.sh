#!/bin/zsh
DATE=$(date +"%Y%m%d%H%M")
DOTFILES_DIR="$HOME/git/dotfiles/mac"

# Backup and link vimrc
if [ -f ~/.vimrc ] && [ ! -L ~/.vimrc ]; then
  mv ~/.vimrc "$DOTFILES_DIR/oldfiles/vimrc-$DATE"
fi
ln -sf "$DOTFILES_DIR/vimrc" ~/.vimrc

# Link Brewfile
ln -sf "$DOTFILES_DIR/Brewfile" ~/Brewfile

# Link p10k config
ln -sf "$DOTFILES_DIR/p10k.zsh" ~/.p10k.zsh

# Link zshrc
ln -sf "$DOTFILES_DIR/zshrc" ~/.zshrc

# Link git hooks
mkdir -p ~/.git-hooks
ln -sf "$DOTFILES_DIR/git-hooks/pre-commit" ~/.git-hooks/pre-commit

# Link Rectangle config
ln -sf "$DOTFILES_DIR/rectangle-config.json" ~/Library/Preferences/com.knollsoft.Rectangle.plist
