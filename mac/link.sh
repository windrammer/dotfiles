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

# Link git editor wrapper
mkdir -p ~/.bin
chmod +x "$DOTFILES_DIR/bin/git-editor-notice"
ln -sf "$DOTFILES_DIR/bin/git-editor-notice" ~/.bin/git-editor-notice

# Link git hooks
mkdir -p ~/.git-hooks
ln -sf "$DOTFILES_DIR/git-hooks/pre-commit" ~/.git-hooks/pre-commit
ln -sf "$DOTFILES_DIR/git-hooks/commit-msg" ~/.git-hooks/commit-msg
chmod +x ~/.git-hooks/pre-commit ~/.git-hooks/commit-msg

# Link commitlint config
ln -sf "$DOTFILES_DIR/commitlint.config.js" ~/commitlint.config.js

# Link Rectangle config
ln -sf "$DOTFILES_DIR/rectangle-config.plist" ~/Library/Preferences/com.knollsoft.Rectangle.plist

# Link git commit template
ln -sf "$DOTFILES_DIR/git-commit-template" ~/.git-commit-template
