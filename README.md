# Eksploracja Danych — AGH

My notebooks and solutions for the Data Exploration course at AGH.

## Labs

| Lab                | Topic                            | Score |
| ------------------ | -------------------------------- | ----- |
| [lab1](labs/lab1/) | PCA and dimensionality reduction | 4/5   |
| [lab2](labs/lab2/) | Classification                   | 5/5   |
| [lab3](labs/lab3/) | Clustering and association       | 5/5   |
| [lab4](labs/lab4/) | Time series (MATLAB)             | 4/5   |

Each lab has a `template` file to work from, a `solution` for reference, an `instructions.pdf`, and a `data/` folder.

## Setup

Requires [uv](https://docs.astral.sh/uv/) and [lefthook](https://github.com/evilmartians/lefthook), and Python 3.12.

```bash
make setup
uv run jupyter notebook
```

## Tooling

| Tool                                                 | Purpose                |
| ---------------------------------------------------- | ---------------------- |
| [ruff](https://docs.astral.sh/ruff/)                 | linting and formatting |
| [ty](https://github.com/astral-sh/ty)                | type checking          |
| [lefthook](https://github.com/evilmartians/lefthook) | git hooks              |

| Command      | What it does               |
| ------------ | -------------------------- |
| `make setup` | install deps and git hooks |
| `make fmt`   | format with ruff           |
| `make lint`  | lint and autofix with ruff |
| `make check` | type-check with ty         |

Commits run ruff and ty automatically. Messages must follow [Conventional Commits](https://www.conventionalcommits.org/).

## Contributing

Open to PRs — better solutions, spotted errors, new labs all welcome. If you're taking the same course, feel free to fork and use the templates as a base.

See [CONTRIBUTING.md](CONTRIBUTING.md).
