install: ## Install the environment using uv
	@echo "🚀 Creating virtual environment using uv"
	@uv sync

format: ## Format code using isort and black.
	@echo "🚀 Formatting code: Running isort and black"
	@uv run isort .
	@uv run black .

check: ## Check code formatting using isort, black, flake8 and mypy.
	@echo "🚀 Checking code formatting: Running isort"
	@uv run isort --check-only --diff .
	@echo "🚀 Checking code formatting: Running black"
	@uv run black --check .
	@echo "🚀 Checking code formatting: Running flake8"
	@uv run flake8 .
	@echo "🚀 Checking code formatting: Running mypy"
	@uv run mypy .

test: ## Test the code with pytest
	@echo "🚀 Testing code: Running pytest"
	@uv run pytest --doctest-modules

build: clean-build ## Build wheel file using uv
	@echo "🚀 Creating wheel file"
	@uv build

dockerize:
	@echo "🚀 Creating docker image"
	@docker build -t reimann:latest .

clean-build: ## clean build artifacts
	@rm -rf dist

docs-test: ## Test if documentation can be built without warnings or errors
	@uv run mkdocs build -s

docs: ## Build and serve the documentation
	@uv run mkdocs serve

collect-static:
	uv run python manage.py collectstatic --noinput

.PHONY: docs

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
