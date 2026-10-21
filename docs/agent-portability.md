# agent portability

one-line summary: one source (rules/yap.md), generated copies per harness.

| harness | file | generated |
|---|---|---|
| claude code | `.claude-plugin/`, `skills/`, `SKILL.md` | skills hand-written, rules block synced |
| codex | `.codex-plugin/`, `AGENTS.md` | no |
| cursor | `.cursor/rules/yap.mdc` | yes |
| cline | `.clinerules/yap.md` | yes |
| windsurf | `.windsurf/rules/yap.md` | yes |
| kiro | `.kiro/steering/yap.md` | yes |
| copilot | `.github/copilot-instructions.md`, `.github/plugin/` | rules yes, plugin manifest no |
| gemini | `gemini-extension.json`, `GEMINI.md`, `commands/*.toml` | GEMINI.md yes |
| opencode | `opencode.json`, `.opencode/command/`, `.opencode/plugins/yap.mjs` | plugin registers skills + commands, rules via instructions |
| qoder | `.qoder/rules/yap.md`, `.qoder-plugin/` | rules yes, plugin manifest no |
| generic agents | `.agents/rules/yap.md` | yes |

## edit flow

| step | command |
|---|---|
| edit rules | change rules/yap.md only |
| regenerate | `python3 scripts/sync-rules.py` |
| verify | `bash scripts/check.sh` |

manifest and rule file formats follow each harness convention at time of writing, verify against its docs when one changes.
