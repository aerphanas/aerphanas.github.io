.PHONY: help

CBL := @cabal
EXE := kompor
CMD := $(CBL) run -- $(EXE)

help:
	@echo "make [dep-update/dep-clean/dep-build/watch/clean/build/rebuild/check]"

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
