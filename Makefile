install: ## Install the poetry environment
	@echo "🚀 Creating virtual environment using pyenv and poetry"
	@poetry install	
	@poetry shell

format: ## Format code using isort and black.
	@echo "🚀 Formatting code: Running isort and black"
	@isort .
	@black .

check: ## Check code formatting using isort, black, flake8 and mypy.
	@echo "🚀 Checking code formatting: Running isort"
	@isort --check-only --diff .
	@echo "🚀 Checking code formatting: Running black"
	@black --check .
	@echo "🚀 Checking code formatting: Running flake8"
	@flake8 .
	@echo "🚀 Checking code formatting: Running mypy"
	@mypy .

test: ## Test the code with pytest
	@echo "🚀 Testing code: Running pytest"
	@pytest --doctest-modules

build: clean-build ## Build wheel file using poetry
	@echo "🚀 Creating wheel file"
	@poetry build

dockerize:
	@echo "🚀 Creating docker image"
	@docker build -t reimann:latest .

clean-build: ## clean build artifacts
	@rm -rf dist

docs-test: ## Test if documentation can be built without warnings or errors
	@mkdocs build -s

docs: ## Build and serve the documentation
	@mkdocs serve

collect-static:
	python manage.py collectstatic --noinput

.PHONY: docs

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help