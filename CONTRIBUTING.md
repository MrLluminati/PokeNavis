# Contributing to PokeNavis

This repository is in **pre-production**. Read [README.md](README.md), [docs/STATUS.md](docs/STATUS.md), [docs/TASKS.md](docs/TASKS.md), and [AGENTS.md](AGENTS.md) before contributing.

## How work is organized

- **Project owner:** approves features, priorities and product decisions.
- **ChatGPT:** coordinates design/specification and can prepare task descriptions.
- **Codex and other contributors:** implement scoped tasks, test, document and propose changes.
- **GitHub:** the durable system of record for code and the current project state. Chat messages are not a substitute for repository documentation.

## Task lifecycle

`Backlog → Ready → In progress → In review → Done`

Use **Blocked** when a necessary approval, dependency, tool or asset is unavailable. Move work into **Ready** only when requirements and acceptance criteria are sufficient.

Start from an item in [docs/TASKS.md](docs/TASKS.md) or an approved GitHub issue. Reference the unique task ID (`PN-001`, etc.) in branches, commits and PRs.

## Branch and merge policy

- Default branch: `main`; keep it understandable and stable.
- For code or product changes, use `codex/PN-###-short-name` or `feature/PN-###-short-name`.
- Submit a pull request; do not force-push `main`.
- Prefer small PRs that solve one task. Document architectural tradeoffs.
- Preserve task links when moving backlog tracking to GitHub Issues/Projects later.
- For urgent fixes, document exceptions and a follow-up review.

## Every PR should include

1. Purpose, linked task ID and concise behavioral changes.
2. Important files changed.
3. Test commands actually run and their results.
4. How reviewers can reproduce or inspect the result.
5. Known limitations, open decisions and follow-up tasks.
6. Documentation updates, if project status, usage or architecture changed.

Use [.github/pull_request_template.md](.github/pull_request_template.md).

## Documentation maintenance

| File | Update when |
| --- | --- |
| `README.md` | Project entry points, dependencies or quickstart change |
| `docs/STATUS.md` | A milestone advances, project-wide blocker appears or immediate next action changes |
| `docs/TASKS.md` | Work begins, is blocked, goes into review, completes or changes scope |
| `docs/DECISIONS.md` | Owner approves or reverses a product/architecture decision |
| `docs/GDD.md` | Approved gameplay rules/content design changes |
| `docs/ARCHITECTURE.md` | Module boundaries, contracts or deployment approach change |
| `docs/ROADMAP.md` | Milestone/scope/priority changes |
| `CHANGELOG.md` | Meaningful, user-visible additions/fixes are merged |

Avoid stale and contradictory docs. A new contributor should be able to find the **current state and next task in under five minutes**.

## Builds and tests

There is currently **no executable project**, so no build or test command can honestly be supplied yet. When client/server packages exist, contributors must document version-pinned prerequisites and commands in the README (and/or each package README).

After implementation begins, preferred verification:
- Battle engine: deterministic unit and replay tests.
- Godot client: project opens, scenes run, input/collision tests and a playable smoke test.
- Backend: unit/integration tests, transaction and idempotency checks.
- Cross-module changes: smoke/integration checks and regression tests.

If tests cannot be run, label them **Not run** and explain why.

## Safety and assets

Only add original or properly licensed code/assets. Do not upload Pokémon ROMs, extracted copyrighted content, secrets or tokens. Never represent an unapproved feature, a pending check or an unexecuted test as complete.
