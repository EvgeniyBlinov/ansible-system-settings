# vim: set noet ci pi sts=0 sw=4 ts=4 :
# http://www.gnu.org/software/make/manual/make.html
# http://linuxlib.ru/prog/make_379_manual.html
SHELL:=/bin/bash
DEBUG ?= 0

CURRENT_DIR := $(shell dirname "$(realpath "$(lastword $(MAKEFILE_LIST))")")
########################################################################
# Default variables
########################################################################
-include .env
export
########################################################################
all:  build

.PHONY: build
build:               \
		.env         \
		requirements \
		.python/bin/activate

#  TODO:  <17-03-19, Evgeniy Blinov <evgeniy_blinov@mail.ru>> # add make variable INVENTORY_NAME
.env:
	export INVENTORY_NAMES="$$(ls -1 inventory/ | xargs -n 1 basename)" ;    \
	if [ 1 -lt "$$(echo $$INVENTORY_NAMES | awk '{print NF; exit}')" ]; then \
		select INVENTORY_NAME in $$INVENTORY_NAMES; do                       \
			export INVENTORY_NAME=$$INVENTORY_NAME ;                         \
			break ;                                                          \
		done ;                                                               \
	else                                                                     \
		export INVENTORY_NAME=$$INVENTORY_NAMES ;                            \
	fi ;                                                                     \
	echo "INVENTORY_NAME=$$INVENTORY_NAME" > $@;                             \
	echo $$INVENTORY_NAME ;

.PHONY: .env-update
.env-update:
	rm .env && $(MAKE) .env

.PHONY: requirements
requirements:
	if ! python3 -c "help('modules');"|grep -q ensurepip ; then \
		sudo apt install -y                                     \
			python3-dev                                         \
			python3-pip                                         \
			python3-venv                                        \
			;                                                   \
	fi

.python/bin/activate:
	python3 -m venv .python &&     \
	source .python/bin/activate && \
	pip3 install --upgrade pip &&  \
	pip3 install -r ./requirements.txt
