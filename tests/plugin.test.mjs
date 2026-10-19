// structural test for the OpenCode plugin, no live client
import { test } from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import plugin from '../.opencode/plugins/dnaism.mjs';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');

function fakeV2() {
  const skills = [];
  const commands = [];
  const prompts = [];
  const ctx = {
    skill: { transform: async (fn) => fn({ add: (s) => skills.push(s) }) },
    command: { transform: async (fn) => fn({ add: (c) => commands.push(c) }) },
    session: { prompt: async (p) => prompts.push(p) },
  };
  return { ctx, skills, commands, prompts };
}

test('single default export with id and both APIs', () => {
  assert.equal(plugin.id, 'dnaism');
  assert.equal(typeof plugin.setup, 'function');
  assert.equal(typeof plugin.server, 'function');
});

test('v2 setup registers every skill dir', async () => {
  const { ctx, skills } = fakeV2();
  await plugin.setup(ctx);
  const dirs = fs.readdirSync(path.join(root, 'skills'), { withFileTypes: true })
    .filter((e) => e.isDirectory()).map((e) => e.name);
  assert.equal(skills.length, dirs.length);
  for (const skill of skills) {
    assert.ok(skill.id && skill.name && skill.description, 'skill has id/name/description');
    assert.ok(skill.content && !skill.content.startsWith('---'), 'content is body without frontmatter');
  }
});

test('v2 setup registers both commands', async () => {
  const { ctx, commands } = fakeV2();
  await plugin.setup(ctx);
  const names = commands.map((c) => c.name).sort();
  assert.deepEqual(names, ['dnaism-learn', 'dnaism-review']);
});

test('command execute fills $ARGUMENTS', async () => {
  const { ctx, commands, prompts } = fakeV2();
  await plugin.setup(ctx);
  const review = commands.find((c) => c.name === 'dnaism-review');
  await review.execute({ sessionID: 's1', prompt: { text: 'feature/login', files: [{ mention: 'x', path: 'a' }] } });
  assert.equal(prompts.length, 1);
  assert.match(prompts[0].text, /feature\/login/);
  assert.ok(!('mention' in prompts[0].files[0]), 'mention stripped');
});

test('v1 config hook adds commands and skills path', async () => {
  const hooks = await plugin.server({ client: {} });
  const config = {};
  await hooks.config(config);
  assert.ok(config.command['dnaism-learn']);
  assert.ok(config.skills.paths.includes(path.join(root, 'skills')));
});
