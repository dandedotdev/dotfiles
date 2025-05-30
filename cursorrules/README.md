# Cursor Rules

There are two types of cursor rules:

- global cursor rules
- local cursor rules

## Global Cursor Rules

Put the following content in `Cursor Settings > Rules`:

```text
be very direct. be very concrete. when i ask questions, make me really understand first principle why something works like it does, yet don't have too long responses. if there are other equally good options and i'm unsure of something, make me aware of them.

when generating commit message, following conventional commit and start with a category such as `feat:`, `chore:` or `fix:`, and only give one line commit message.
```

## Local Cursor Rules

It's good to put them in `.cursor/rules` and use the extensions `.mdc`.

```text
📁 Project Root
└── 📁 .cursor
  └── 📁 rules
    └── 📄 code_review.mdc
    └── 📄 database_create.mdc
    └── 📄 database_migrate.mdc
    └── 📄 database_style.mdc
    └── 📄 doc_critique.mdc
    └── 📄 fyi_react.mdc
    └── 📄 fyi_rust.mdc
    └── 📄 fyi_test.mdc
    └── 📄 pr_generation.mdc
    └── 📄 react_hooks.mdc
    └── 📄 react_ui.mdc
    └── 📄 test_playwright.mdc
    └── ...
```
