# Cursor

## Rules

There are two types of cursor rules:

- **Global cursor rules**: Applied across all your projects.
- **Local cursor rules**: Project-specific rules stored within your repository.

### Global Cursor Rules

Put the following content in `Cursor Settings > General > Rules`:

```text
be very direct. be very concrete. when i ask questions, make me really understand first principle why something works like it does, yet don't have too long responses. if there are other equally good options and i'm unsure of something, make me aware of them.

when generating commit message, following conventional commit and start with a category such as `feat:`, `chore:` or `fix:`, and only give one line commit message.
```

### Local Cursor Rules

For project-specific logic, it is recommended to organize them within the `.cursor` directory. Based on the current project structure, we use `.mdc` for rules and `.md` for specific command prompts.

```text
📁 Project Root
└── 📁 .cursor
  ├── 📁 commands
  │ ├── 📄 code-review.md
  │ ├── 📄 collaborate.md
  │ ├── 📄 essentialize.md
  │ └── 📄 prioritize.md
  ├── 📁 rules
  │ ├── 📄 clickhouse.mdc
  │ ├── 📄 rust.mdc
  │ └── 📄 typescript.mdc
  ├── 📄 mcp.json
  └── 📄 worktrees.json
```

> **Tip:**
>
> - Files with the `.mdc` extension in the `.cursor/rules` folder are automatically indexed by Cursor to provide context-aware assistance.
> - The `mcp.json` file is used to configure the MCP servers. You can add more instructions in `*.mcp` files in `.cursor/rules` folder.

### Acknowledgement

Some of these cursor rules and structures are inspired by:

- [Cursor Rules for Better AI Development by Matt Pocock](https://www.totaltypescript.com/cursor-rules-for-better-ai-development)
- [hamzafer/cursor-commands](https://github.com/hamzafer/cursor-commands)
- [PatrickJS/awesome-cursorrules](https://github.com/PatrickJS/awesome-cursorrules)
- [twostraws/SwiftAgents](https://github.com/twostraws/SwiftAgents)

## Worktrees

Configure git worktrees for parallel development across multiple branches in the same repository. This is managed via the `worktrees.json` file in the `.cursor` folder.

> - [Parallel Agents | Cursor Docs](https://cursor.com/docs/configuration/worktrees)

## Better Coding Agents

You can clone repositories as git subtrees into your project. This provides excellent documentation for AI assistants, as they can reference and learn from these codebases.

> - [bmdavis419/.better-coding-agents](https://github.com/bmdavis419/.better-coding-agents)
