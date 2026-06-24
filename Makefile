.PHONY: setup fmt lint check

setup:
	uv sync
	lefthook install

fmt:
	uv run ruff check --select I --fix .
	uv run ruff format .

lint:
	uv run ruff check --fix .

check:
	uv run ty check
