# install

one-line summary: pick your harness, placeholders are `<user>` and `<repo-url>`.

| harness | how |
|---|---|
| claude code (plugin) | `/plugin marketplace add <user>/yap` then `/plugin install yap@yap` |
| claude code (manual) | `bash scripts/link-skills.sh` |
| codex | copy `AGENTS.md` and `skills/` into the project or enable the plugin |
| cursor | copy `.cursor/rules/yap.mdc` into the project |
| cline | copy `.clinerules/yap.md` |
| windsurf | copy `.windsurf/rules/yap.md` |
| kiro | copy `.kiro/steering/yap.md` |
| copilot | copy `.github/copilot-instructions.md`, or install the `.github/plugin/` plugin |
| qoder | copy `.qoder/rules/yap.md`, or install the `.qoder-plugin/` plugin |
| gemini | `gemini extensions install <repo-url>` |
| opencode | add `<repo>/.opencode/plugins/yap.mjs` to the `plugin` array in `opencode.json` (global `~/.config/opencode/opencode.jsonc` to load everywhere) |
| anything else | paste `rules/yap.md` into its rules file |

the opencode plugin registers every `skills/*` skill and both `.opencode/command/` commands; the always-on rules load separately through `opencode.json` `instructions`.

remove skill links with `bash scripts/uninstall.sh`.
