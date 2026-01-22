# Acknowledgements

The agent skills configured in this directory were installed and managed using **[OpenSkills](https://github.com/numman-ali/openskills)**.

We gratefully acknowledge the following repositories for providing the skills currently available in this project:

* **[vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills)**
* **[anthropics/skills](https://github.com/anthropics/skills)**
* **[obra/superpowers](https://github.com/obra/superpowers)**

Here are some awesome Claude Code Configuration:

* **[affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code)**

## Requirements

To ensure proper functionality, please make sure the following environment setting is enabled:

* **Enable Cursor Nightly:** You must enable Cursor Nightly. Press Cmd + Shift + J to toggle this feature on.

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

## Installation Log

For reference, these skills were installed using the following commands:

```bash
pnpm dlx openskills install vercel-labs/agent-skills
pnpm dlx openskills install anthropics/skills
pnpm dlx openskills install obra/superpowers
```
