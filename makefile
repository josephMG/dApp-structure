SUBDIRS = hardhat backend frontend
CURRENT_DIR := $(shell pwd)

define FOREACH
    for DIR in $(SUBDIRS); do \
				echo "=============  $(1) > $(CURRENT_DIR)/$$DIR"; \
        cd $(CURRENT_DIR)/$$DIR && $(1); \
    done
endef

all: build up
clean: down stop-rm-volume prune

up:
	parallel -j3 --lb 'cd ${PWD}/{} ; docker-compose --ansi always up' ::: $(SUBDIRS)

build:
	$(call FOREACH, docker-compose build)

down:
	$(call FOREACH, docker-compose down)

stop-rm:
	$(call FOREACH, docker-compose rm -sf)

stop-rm-volume:
	$(call FOREACH, docker-compose rm -sfv)

prune:
	docker system prune -af
