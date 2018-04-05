TAG:=latest
ENTRYPOINT:=/entrypoint.sh
ARGS:=
COMMAND:=/bin/bash

build:
	@./scripts/build.sh $(TAG)

clean:
	@./scripts/clean.sh $(TAG)

run:
	@./scripts/run.sh $(TAG) $(ENTRYPOINT) $(ARGS)

debug:
	@./scripts/debug.sh $(TAG) $(COMMAND)

push:
	@./scripts/push.sh $(TAG)


.PHONY: build clean run debug push
