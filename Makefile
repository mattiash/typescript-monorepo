.PHONY: build test test-cov clean

# Directories to run targets in
DIRS := common service-a service-b

# Main targets that run across all directories
build:
	@for dir in $(DIRS); do \
		echo "Building $$dir..."; \
		$(MAKE) -C $$dir build || exit 1; \
	done

test:
	@for dir in $(DIRS); do \
		echo "Testing $$dir..."; \
		$(MAKE) -C $$dir test || exit 1; \
	done

test-cov:
	npx --no -- c8 -r html multi-tape */build/test/test-*.js */build/test/**/test-*.js
	@echo Coverage report coverage/index.html
	
clean:
	@for dir in $(DIRS); do \
		echo "Cleaning $$dir..."; \
		$(MAKE) -C $$dir clean || exit 1; \
	done