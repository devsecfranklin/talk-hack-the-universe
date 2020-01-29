.PHONY: docker python test

REQS := requirements.txt

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
  match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
  if match:
    target, help = match.groups()
    print("%-20s %s" % (target, help))
endef

export PRINT_HELP_PYSCRIPT

help: 
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

docker: ## build docker container for testing
	@echo "Building test env with docker-compose"
	docker-compose -f docker/docker-compose.yml build hack_the_universe
	@docker-compose -f docker/docker-compose.yml run hack_the_universe /bin/bash

python: ## setup python3
	if [ -f 'python/requirements.txt' ]; then pip3 install -rpython/requirements.txt; fi

test: python ## run tests in container
	if [ -f 'python/requirements-test.txt' ]; then pip3 install -rpython/requirements-test.txt; fi
	cd python && tox
