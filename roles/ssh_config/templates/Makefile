# vim: set noet ci pi sts=0 sw=4 ts=4 :
# {{ ansible_managed }}
# http://www.gnu.org/software/make/manual/make.html
# http://linuxlib.ru/prog/make_379_manual.html
SHELL:=/bin/bash

all: \
		{{ ssh_config__dir }} \
		generate_config

.PHONY: generate_config
generate_config:
	cat {{ ssh_config__dir }}/* > {{ ssh_config__config_path }}.tmp
	if ! diff -q  {{ ssh_config__config_path }} {{ ssh_config__config_path }}.tmp ; then \
		cp {{ ssh_config__config_path }} {{ ssh_config__config_path }}-$$(date +%s).bak 2> /dev/null || echo done > /dev/null ;\
		cp  {{ ssh_config__config_path }}.tmp {{ ssh_config__config_path }} ;\
	fi
	rm {{ ssh_config__config_path }}.tmp

{{ ssh_config__dir }}:
	mkdir -p $@

.PHONY: env
env:
	if test -L {{ ssh_config__dir }} ; then                        \
		rm {{ ssh_config__dir }} ;                                 \
	fi ;                                                           \
	if test -d {{ ssh_config__dir }}_$(ENV) ; then                 \
		ln -s {{ ssh_config__dir }}_$(ENV) {{ ssh_config__dir }} ; \
	fi

