# Date : 28/11/23
# Author : Arthur Djikpo
 

DC=docker compose
.DEFAULT_GOAL := help

.PHONY: help ## Generate list of targets with descriptions
help:
		@grep '##' Makefile \
		| grep -v 'grep\|sed' \
		| sed 's/^\.PHONY: \(.*\) ##[\s|\S]*\(.*\)/\1:\2/' \
		| sed 's/\(^##\)//' \
		| sed 's/\(##\)/\t/' \
		| expand -t14

##
## Project setup & day to day shortcuts
##---------------------------------------------------------------------------

.PHONY: install ## Install the project (Install in first place)
install:
	$(DC) pull || true
	$(DC) build
	$(DC) up -d

.PHONY: stop ## stop the project
stop:
	$(DC) down

.PHONY: restart ## Restart the container
restart:
	$(DC) down
	$(DC) build
	$(DC) up -d


