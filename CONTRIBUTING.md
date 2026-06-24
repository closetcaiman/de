# Contributing

## Getting started

```bash
git clone <repo>
cd de
uv sync
lefthook install
```

## Workflow

1. Fork and clone the repo.
2. Make your changes — fix a solution, improve instructions, add a lab.
3. Open a PR with a short description of what changed and why.

## Commit messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>[optional scope]: <description>
```

Types: `feat`, `fix`, `docs`, `refactor`, `chore`.

```
feat(labs/lab3): add clustering solution for ingredients dataset
fix(labs/lab4): correct moving average window indexing
docs: update labs/lab2 instructions formatting
```

The commit-msg hook rejects anything that doesn't match.

## Code style

Ruff handles linting and formatting:

```bash
uv run ruff check --fix
uv run ruff format
```

Type checking:

```bash
uv run ty check
```
