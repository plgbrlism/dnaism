// yap OpenCode plugin.
//
// Registers the yap-* skills and the yap commands so they resolve when this repo
// is on the plugin path. The always-on rules load separately through
// opencode.json `instructions`, so this plugin does not touch the system prompt.
//
// One default export serves both plugin APIs: V2 reads `id` + `setup`, V1 calls
// `server()`.

import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// the root SKILL.md names the library, fall back to the repo folder
const rootSkill = path.resolve(__dirname, '../../SKILL.md');

// flat frontmatter only, the shape every shipped SKILL.md uses
function field(frontmatter, key) {
  const line = frontmatter.split(/\r?\n/).find((l) => l.startsWith(key + ':'));
  return line && line.slice(key.length + 1).trim();
}

function parseCommandFile(filePath) {
  const content = fs.readFileSync(filePath, 'utf8');
  const match = content.match(/^---\r?\n([\s\S]*?)\r?\n---[^\S\n]*\r?\n?([\s\S]*)$/);
  if (!match) return null;
  return { description: field(match[1], 'description'), template: match[2].trim() };
}

function parseSkillFile(filePath) {
  const content = fs.readFileSync(filePath, 'utf8');
  const match = content.match(/^---\r?\n([\s\S]*?)\r?\n---[^\S\n]*\r?\n?([\s\S]*)$/);
  if (!match) return null;
  return { name: field(match[1], 'name'), description: field(match[1], 'description'), body: match[2] };
}

const id = (fs.existsSync(rootSkill) && parseSkillFile(rootSkill)?.name) || 'yap';

function readCommands() {
  const dir = path.join(__dirname, '..', 'command');
  try {
    return fs.readdirSync(dir)
      .filter((file) => file.endsWith('.md'))
      .map((file) => {
        const parsed = parseCommandFile(path.join(dir, file));
        return parsed && { name: path.basename(file, '.md'), ...parsed };
      })
      .filter(Boolean);
  } catch (e) {
    return [];
  }
}

function readSkills() {
  const dir = path.resolve(__dirname, '../../skills');
  try {
    return fs.readdirSync(dir, { withFileTypes: true })
      .filter((entry) => entry.isDirectory())
      .map((entry) => {
        const file = path.join(dir, entry.name, 'SKILL.md');
        const parsed = parseSkillFile(file);
        return parsed && {
          id: entry.name,
          name: parsed.name || entry.name,
          description: parsed.description,
          path: file,
          content: parsed.body,
        };
      })
      .filter(Boolean);
  } catch (e) {
    return [];
  }
}

// templates without $ARGUMENTS would drop what the user typed after the command
function withArguments(template, input) {
  const text = String(input == null ? '' : input);
  if (template.includes('$ARGUMENTS')) return template.replaceAll('$ARGUMENTS', text);
  return text.trim() ? template + '\n\n' + text.trim() : template;
}

export default {
  id,

  async setup(ctx) {
    const skills = readSkills();
    const commands = readCommands();

    await ctx.skill.transform((editor) => {
      for (const skill of skills) editor.add(skill);
    });

    await ctx.command.transform((editor) => {
      for (const command of commands) {
        editor.add({
          name: command.name,
          description: command.description,
          execute: async ({ sessionID, prompt, delivery }) => {
            const withoutMentions = (items) => items?.map(({ mention, ...item }) => item);
            await ctx.session.prompt({
              ...prompt,
              sessionID,
              text: withArguments(command.template, prompt.text),
              files: withoutMentions(prompt.files),
              agents: withoutMentions(prompt.agents),
              skills: withoutMentions(prompt.skills),
              delivery,
            });
          },
        });
      }
    });
  },

  // OpenCode V1: same registration through the config hook.
  async server({ client } = {}) {
    const log = (level, message) => {
      try { client && client.app && client.app.log({ body: { service: id, level, message } }); } catch (e) {}
    };

    return {
      config: async (config) => {
        if (!config.command) config.command = {};
        for (const command of readCommands()) {
          config.command[command.name] = { description: command.description, template: command.template };
        }

        config.skills = config.skills || {};
        config.skills.paths = config.skills.paths || [];
        const skillsDir = path.resolve(__dirname, '../../skills');
        if (!config.skills.paths.includes(skillsDir)) {
          config.skills.paths.push(skillsDir);
          log('info', id + ' skills registered: ' + skillsDir);
        }
      },
    };
  },
};
