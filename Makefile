.PHONY: help clean clean_docs docs run_docs clean_guides guides run_guides autodocs

all: help

help:
	@echo "clean        - remove all build artifacts"
	@echo "clean_docs   - remove all docs artifacts"
	@echo "check        - check poetry file for descrepencies, used by CI"
	@echo "install      - install all python dependencies"
	@echo "lint         - run all code quality and linting checks"
	@echo "test         - run all unit tests with coverage"
	@echo "build        - build the python package"
	@echo "docs         - compile the documentation using Sphinx"
	@echo "run_docs     - run the docs on port 8000"

clean:
	rm -rf build dist

clean_docs:
	$(MAKE) -C docs clean

check:
	poetry check --lock

install:
	poetry install --compile

lint: install
	poetry run pre-commit run --all-files

test: install
	poetry run pytest --cov-report=xml --cov-report=html

build: clean install
	poetry build

docs: clean_docs autodocs
	$(MAKE) -C docs html

autodocs:
	poetry run sphinx-apidoc --separate --templatedir docs/_templates -o docs/reference/ pymongoexpr/
	rm -rf docs/reference/modules.rst

run_docs:
	poetry run python -m http.server -d docs/_build/html 8000
