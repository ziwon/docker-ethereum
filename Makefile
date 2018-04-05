ENTRYPOINT:=/entrypoint.sh
TAG:=latest
RUN:=/labs/console.sh

build:
	@./scripts/build.sh $(TAG)

clean:
	@./scripts/clean.sh $(TAG)

run:
	@./scripts/run.sh $(TAG) $(ENTRYPOINT)

push:
	@./scripts/push.sh $(TAG)


.PHONY: build clean run push
