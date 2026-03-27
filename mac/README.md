# Things not managed in playbook

## Git commit editor behavior

- Git commit editing uses `~/.bin/git-editor-notice` via `GIT_EDITOR`.
- If the editor exits with a non-zero status while editing `COMMIT_EDITMSG`, the wrapper:
	- inserts a visible commented banner (with emoji, timestamp, and exit code) directly under the commit title line (without duplicating it), and
	- automatically reopens the same commit message in Vim once.
- If the retry succeeds, no terminal error is shown; if retry still fails, the terminal failure warning is printed.
- You can still abort manually in Vim with `:q!`.

1password
calbar

## 🏗️ git pushbuild

Push and trigger a Woodpecker CI build in one command. The API token is stored in macOS Keychain — nothing in shell profiles or dotfiles.

```bash
git pushbuild          # push to origin + trigger Woodpecker pipeline
```

**First-time setup — store the token:**
```bash
security add-generic-password -s woodpecker-api-token -a token -w "<YOUR_TOKEN>"
```

**Update the token:**
```bash
security delete-generic-password -s woodpecker-api-token -a token 2>/dev/null
security add-generic-password -s woodpecker-api-token -a token -w "<NEW_TOKEN>"
```

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

