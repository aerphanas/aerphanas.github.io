.PHONY: help

CBL := @cabal
EXE := kompor
CMD := $(CBL) run -- $(EXE)
SCRIPT-DIR := ./script/

help:
	@echo "make [dep-update/dep-clean/dep-build/watch/clean]"
	@echo "     [build/rebuild/check/script-init/script-clean/new]"

dep-update:
	$(CBL) update

dep-clean:
	$(CBL) clean

dep-build:
	$(CBL) build

watch:
	$(CMD) watch

clean:
	$(CMD) clean

build:
	$(CMD) build

rebuild:
	$(CMD) rebuild

check:
	$(CMD) check

script-init: $(SCRIPT-DIR)new-post.ros
	ros build $(SCRIPT-DIR)new-post.ros --disable-compression

script-clean:
	find $(SCRIPT-DIR) -type f ! -name "*.*" -delete

new: $(SCRIPT-DIR)new-post
	@./$(SCRIPT-DIR)new-post
