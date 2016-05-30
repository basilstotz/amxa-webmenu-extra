TARGETS = init build clean publish
NAME = "amxa-webmenu-extra"

.PHONY: ${TARGETS}
.PHONY: help

help:
	@echo "Targets are:"
	@echo "   ${TARGETS}" | fmt

init:
	@./bin/init.sh ${NAME}

clean:
	@./bin/clean.sh ${NAME}

build:
	@./bin/build.sh ${NAME}

publish:
	@./bin/publish.sh ${NAME}
	
