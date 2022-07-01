SUBDIRS = hardhat backend frontend
CURRENT_DIR := $(shell pwd)

define FOREACH
    for DIR in $(SUBDIRS); do \
				echo "=============  $(1) > $(CURRENT_DIR)/$$DIR"; \
        cd $(CURRENT_DIR)/$$DIR && $(1); \
    done
endef

all: build up
clean: stop-rm-volume prune

.PHONY: up $(SUBDIRS)
up:
	parallel -j3 --lb 'cd ${PWD}/{} ; docker-compose up' ::: $(SUBDIRS)

.PHONY: build $(SUBDIRS)
build:
	$(call FOREACH, docker-compose build)
	#parallel -j3 --lb 'cd ${PWD}/{} ; docker-compose build' ::: hardhat backend frontend

.PHONY: stop-rm $(SUBDIRS)
stop-rm:
	$(call FOREACH, docker-compose rm -sf)
	#parallel -j3 --lb 'cd ${PWD}/{} ; docker-compose rm -sf' ::: hardhat backend frontend

.PHONY: stop-rm-volume $(SUBDIRS)
stop-rm-volume:
	$(call FOREACH, docker-compose rm -sfv)
	#parallel -j3 --lb 'cd ${PWD}/{} ; docker-compose rm -sfv' ::: hardhat backend frontend

prune:
	docker system prune -af
