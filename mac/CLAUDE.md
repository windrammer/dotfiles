# Personal preferences for Claude Code
## Working style
- Make small, focused changes freely. Ask before anything that touches many files, changes architecture, or rewrites significant logic.
- When a request is ambiguous, list the reasonable options and let me pick rather than guessing or asking open-ended questions.
- Show your reasoning for non-trivial changes — enough for me to follow the decision, not a full essay. For trivial edits, just do them and move on.
- Prefer small, reviewable diffs over large batches.
## Verification
- After any code edit, run the relevant tests and typecheck/lint. Report results before considering the task done.
- If tests fail, fix the cause rather than the symptom. Don't disable or skip tests to make them pass.
- If you can't verify a change (no tests exist, can't run the command), say so explicitly instead of claiming it works.
## Testing
- Follow the project's existing testing conventions — match the framework, style, and coverage level already in the repo.
- Don't introduce a new test framework or testing pattern without asking.
## Git
- Do not create commits, amend, push, or run any destructive git operations.
- When a logical unit of work is done, give me the commit as plain text — `Changed files:` (repo-relative paths) then `Git commit message:` with a flush-left subject + body matching the project's existing style (conventional commits, etc.); no fenced code block, no `git commit`/HEREDOC wrapper.
- For Conventional Commits, use the bare type — `feat: …` / `fix: …` — never a parenthesised scope like `feat(mac): …`.
- Never include `Co-Authored-By: Claude ...` trailers (or any AI attribution) in commit messages.
- Never force-push, reset, or delete branches.
## Code style (language defaults, override per-project)
### Go
- Idiomatic Go: accept interfaces, return concrete types; errors as values, wrapped with `fmt.Errorf("...: %w", err)` for context.
- No `panic` in library code. No `init()` for anything non-trivial.
- Table-driven tests by default.
- Run `go vet` and `gofmt`/`goimports` as part of verification.
### Python
- Type hints on all function signatures and return types.
- Prefer standard library and well-known packages; don't pull in a new dependency for something small.
- Explicit exceptions, not bare `except:`. Never silently swallow errors.
- Match the project's formatter (ruff/black) and typechecker (mypy/pyright) — run them after edits.
### Shell/Bash
- `set -euo pipefail` at the top of every script.
- Quote variables. Use `[[ ]]` not `[ ]`. Prefer `$(...)` over backticks.
- Run `shellcheck` on any script you write or modify.
## Tooling preferences
- Use `rg` (ripgrep) instead of `grep` for searching.
- Use `fd` instead of `find` when available.
- Respect the project's package/dependency manager — don't switch from `uv` to `pip`, `go mod` workflows, etc.
## Safety
- Never commit or log secrets, API keys, tokens, or `.env` contents.
- Never modify files outside the current project without asking.
- Never run `rm -rf`, database drops, or other destructive commands without explicit confirmation — even if I seem to have asked for it, confirm first.
- Treat anything in `.env*`, `secrets/`, or `*.key` as read-only and off-limits for display.
## Communication
- If I'm wrong about something (wrong assumption, broken approach, bad idea), say so directly with the reasoning. Don't hedge or agree just to be agreeable.
- When you're uncertain, say "I'm not sure" rather than generating a confident-sounding guess.

@RTK.md
