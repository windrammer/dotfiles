# Things not managed in playbook

1password
calbar

# Check user path in link script and run the ansible playbook

If autocomplete or directories are not changing colour, adjust black bright and cyan bright

ansible path
export PATH="/Users/shantanu/Library/Python/3.9/bin:$PATH"

## Manually Export Configuration Files

### Rectangle Configuration
To export the current Rectangle config to the repo:
```bash
plutil -convert xml1 ~/Library/Preferences/com.knollsoft.Rectangle.plist -o ~/git/dotfiles/mac/rectangle-config.plist
```

### iTerm2 Configuration
To export the current iTerm2 profile:
```bash
# Get the profile name (usually "Default" or your custom profile name)
# Then export it to JSON:
plutil -convert json -o ~/git/dotfiles/mac/iterm-profile-from-dotfiles.json ~/Library/Preferences/com.googlecode.iterm2.plist
# Or use iTerm2's built-in export: Preferences > Profiles > Other Actions > Save Profile as JSON
```

