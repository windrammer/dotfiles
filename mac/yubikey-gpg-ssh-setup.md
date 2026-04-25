# GPG + YubiKey Setup Guide

## Overview

Complete GPG identity with master key + subkeys, backed up to encrypted USB, loaded onto 4 YubiKey 5 series devices. Configured for git commit signing, SSH authentication to servers, encryption, and FIDO2 2FA.

---

## Key Details

| Item | Value |
|------|-------|
| Master Key | `ed25519/0xEECA864712AA15B0` |
| Fingerprint | `D1E6 108F 1BF3 C6AF 53C0 6986 EECA 8647 12AA 15B0` |
| Signing Subkey | `ed25519/0xB4D72DB9C9D8B4FB` [S] |
| Encryption Subkey | `cv25519/0x94526BD7E1B93819` [E] |
| Authentication Subkey | `ed25519/0x341CE9B00DE56660` [A] |
| Subkey Expiry | 2027-06-06 (Swedish National Day, renewed annually) |
| UIDs | `David Tollman <mail@toll.is>`, `David Tollman <david.tollman@playgroundtech.io>` |

## Hardware

- **4× YubiKey 5C Nano** — daily carry, work, private laptop, backup/spare
- **1× Kingston IronKey** (mounted at `/Volumes/Secure_Key`) — master key backup

## Key Architecture

```
Master Key (ed25519, certify only, no expiry, offline on IronKey)
├── Signing subkey (ed25519, expires 2027-06-06)       → all 4 YubiKeys
├── Encryption subkey (cv25519, expires 2027-06-06)    → all 4 YubiKeys
└── Authentication subkey (ed25519, expires 2027-06-06) → all 4 YubiKeys
```

## YubiKey Configuration

- Same user PIN and admin PIN on all 4 keys (saved on IronKey)
- PIN retry counter: 10 attempts (user, reset code, admin)
- Touch policy: enabled for signing, encryption, and authentication
- OpenPGP applet only — FIDO2 is configured separately per key

## SSH Split Workflow

- **GitHub push/pull** → regular SSH key (`~/.ssh/id_ed25519`), no YubiKey
- **SSH to servers** → GPG auth subkey via YubiKey, touch required
- **Git commit signing** → GPG signing subkey via YubiKey, touch required

GitHub is configured in `~/.ssh/config` to bypass `gpg-agent`:

```
Host github.com
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
```

GPG SSH public key for servers is saved at `~/.ssh/gpg-yubikey.pub`.

## Backup Contents (on IronKey at `/Volumes/Secure_Key/gpg-backup/`)

- `secret-keys.asc` — master + all subkeys (armor export)
- `public-key.asc` — public key with both UIDs
- `ownertrust.txt` — trust database
- `revocation-cert.rev` — revocation certificate
- `pins.txt` — user PIN and admin PIN
- `recovery-codes.txt` — FIDO2 recovery codes for GitHub, 1Password, etc.

## Configuration Files

### `~/.gnupg/gpg-agent.conf`

```
default-cache-ttl 3600
max-cache-ttl 14400
pinentry-program /opt/homebrew/bin/pinentry-mac
enable-ssh-support
```

### Shell rc (`~/.zshrc` or equivalent)

```bash
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
```

### Git global config

```bash
git config --global user.signingkey B4D72DB9C9D8B4FB
git config --global commit.gpgsign true
git config --global tag.gpgsign true
```

---

## Cheat Sheet

### Switching YubiKeys

When you plug in a different YubiKey than the one GPG last saw:

```bash
gpg-connect-agent "scd serialno" "learn --force" /bye
```

### Signing fails with "No such file or directory"

Symptom: `git commit` or `gpg --clearsign` errors with `signing failed: No such file or directory`, no PIN prompt, no touch request. Usually caused by stale gpg-agent / scdaemon state (e.g., agent started before the public key was imported, or a YubiKey was hot-swapped). Fix:

```bash
gpgconf --kill all
```

Next `gpg` invocation relaunches the agent fresh via the shell rc. If it persists, also run `gpg-connect-agent "scd serialno" "learn --force" /bye` to re-bind the card.

### Verifying the card ↔ keyring link

`gpg --card-status` should end with `General key info..: sub  ed25519/B4D72DB9C9D8B4FB ...`. If it says `[none]`, the public key isn't imported — see "Setting Up on a New Machine" step 1.

### Annual Subkey Renewal (every June 6th)

1. Plug in the IronKey
2. Import the master secret key:
   ```bash
   gpg --import /Volumes/Secure_Key/gpg-backup/secret-keys.asc
   ```
3. Extend subkey expiration:
   ```bash
   gpg --edit-key --expert 0xEECA864712AA15B0
   ```
   For each subkey: `key N` → `expire` → set to next year's `YYYY-06-06` → `key N` to deselect. Then `save`.
4. Update the backup:
   ```bash
   gpg --export-secret-keys --armor 0xEECA864712AA15B0 > /Volumes/Secure_Key/gpg-backup/secret-keys.asc
   gpg --export --armor 0xEECA864712AA15B0 > /Volumes/Secure_Key/gpg-backup/public-key.asc
   ```
5. Update public key on GitHub:
   ```bash
   gpg --export --armor 0xEECA864712AA15B0 | pbcopy
   ```
   GitHub → Settings → SSH and GPG keys → delete old → add new.
6. No need to touch the YubiKeys — subkeys are unchanged.

### If a YubiKey is Lost or Compromised

1. Your other YubiKeys still work identically for GPG (same subkeys).
2. If compromised (not just lost), consider rotating subkeys from master key backup.
3. Remove the lost key's FIDO2 registrations from each service (GitHub, 1Password, etc.).
4. To set up a replacement:
   - Import from IronKey backup
   - `keytocard` to load subkeys onto new YubiKey
   - Set PINs: `gpg --edit-card` → `admin` → `passwd`
   - Set retry count: `ykman openpgp access set-retries 10 10 10 -a YOUR_ADMIN_PIN`
   - Set touch policy:
     ```bash
     ykman openpgp keys set-touch sig on -a YOUR_ADMIN_PIN
     ykman openpgp keys set-touch enc on -a YOUR_ADMIN_PIN
     ykman openpgp keys set-touch aut on -a YOUR_ADMIN_PIN
     ```
   - Register FIDO2 with each service again

### Factory Resetting a Locked YubiKey

If locked out of the OpenPGP applet (wrong PIN too many times):

```bash
ykman openpgp reset --force
```

Wipes OpenPGP only (FIDO2 unaffected). Reload subkeys from backup and reconfigure.

### Adding SSH Key to a Server

```bash
ssh-copy-id -f -i ~/.ssh/gpg-yubikey.pub user@server
```

Or manually append the contents of `~/.ssh/gpg-yubikey.pub` to `~/.ssh/authorized_keys` on the server.

### Setting Up on a New Machine

1. Import your public key:
   ```bash
   gpg --import /Volumes/Secure_Key/gpg-backup/public-key.asc
   gpg --import-ownertrust /Volumes/Secure_Key/gpg-backup/ownertrust.txt
   ```
2. Install: `brew install gpg ykman pinentry-mac`
3. Set up `~/.gnupg/gpg-agent.conf` and shell rc as above
4. Set up `~/.ssh/config` for GitHub
5. Copy `~/.ssh/gpg-yubikey.pub` for server access
6. Configure git signing as above
7. Restart the agent so it picks up the new key + pinentry config:
   ```bash
   gpgconf --kill all
   ```
   The next `gpg` invocation will relaunch it via the shell rc.
8. Plug in YubiKey — it just works

---

## Notes

- **Touch ID for PIN entry (optional):** Configure `pinentry-mac` + macOS Keychain to use Touch ID instead of typing the PIN. When `pinentry-mac` prompts for the YubiKey PIN, check "Save in Keychain." Subsequent prompts go through Touch ID → Keychain → PIN automatically.
- **FIDO2 is separate from GPG.** Each YubiKey generates unique FIDO2 keypairs per service. All 4 keys are registered independently with GitHub, 1Password, and any other services. Losing a key means re-registering the replacement with each service.
