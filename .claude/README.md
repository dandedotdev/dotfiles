# Acknowledgements

The agent skills configured in this directory were installed and managed using **[OpenSkills](https://github.com/numman-ali/openskills)**.

> Alternative: **[vercel-labs/add-skill](https://github.com/vercel-labs/add-skill)**

I gratefully acknowledge the following repositories for providing the skills currently available in this project:

* **[antfu/skills](https://github.com/antfu/skills)**
* **[anthropics/skills](https://github.com/anthropics/skills)**
* **[Dimillian/Skills](https://github.com/Dimillian/Skills)**
* **[harryworld/Xcode26-Agent-Skills](https://github.com/harryworld/Xcode26-Agent-Skills)**
* **[nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill)**
* **[obra/superpowers](https://github.com/obra/superpowers)**
* **[pzep1/xcode-build-skill](https://github.com/pzep1/xcode-build-skill)**
* **[remotion-dev/skills](https://github.com/remotion-dev/skills)**
* **[slidevjs/slidev](https://github.com/slidevjs/slidev)**
* **[spences10/svelte-claude-skills](https://github.com/spences10/svelte-claude-skills)**
* **[vercel/turborepo](https://github.com/vercel/turborepo)**
* **[vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills)**

Here are some awesome Claude Code Configuration:

* **[affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code)**
* **[anthropics/claude-cookbooks](https://github.com/anthropics/claude-cookbooks)**
* **[anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official)**

## Requirements

To ensure proper functionality, please make sure the following environment setting is enabled:

* **Enable Cursor Nightly:** You must enable Cursor Nightly. Press `Cmd` + `Shift` + `J` to toggle this feature on.

## Management

To synchronize the skills and ensure everything is up to date, run the following command:

```bash
pnpm dlx openskills sync
```

Remember to manage personal skills in the `AGENTS.md` file.

```md
<skill>
<name>clickhouse-patterns</name>
<description>Use when designing ClickHouse table schemas, choosing MergeTree engines, optimizing slow queries (execution time > 1 second), or implementing batch INSERT patterns. Does NOT cover real-time streaming from message queues or database replication/CDC - see related skills for those topics.</description>
<location>project</location>
</skill>
```

> Only enable skills that are relevant to the project and the task at hand.

## Installation Log

For reference, these skills were installed using the following commands:

```bash
pnpm dlx openskills install anthropics/skills
pnpm dlx openskills install obra/superpowers
pnpm dlx openskills install vercel-labs/agent-skills
```
