DEV_ROCKS = "lua-cjson 2.1.0" "kong 0.13.0" "luacov 0.12.0" "busted 2.0.rc12" "luacov-cobertura 0.2-1" "luacheck 0.20.0"
PROJECT_FOLDER = url-rewrite
LUA_PROJECT = kong-plugin-url-rewrite
VERSION = 0.6.0-0

setup:
	cp rockspec.template kong-plugin-url-rewrite-$(VERSION).rockspec
	@for rock in $(DEV_ROCKS) ; do \
		if luarocks list --porcelain $$rock | grep -q "installed" ; then \
			echo $$rock already installed, skipping ; \
		else \
			echo $$rock not found, installing via luarocks... ; \
			luarocks install $$rock; \
		fi \
	done;

check:
	@for rock in $(DEV_ROCKS) ; do \
		if luarocks list --porcelain $$rock | grep -q "installed" ; then \
			echo $$rock is installed ; \
		else \
			echo $$rock is not installed ; \
		fi \
	done;

install:
	-@luarocks remove $(LUA_PROJECT)
	luarocks make

docker-build:
	docker build . -t $(LUA_PROJECT)

docker-run:
	docker run -it -v $(shell pwd):/home/plugin $(LUA_PROJECT) /bin/bash

test:
	cd $(PROJECT_FOLDER) && busted spec/ ${ARGS}

coverage:
	cd $(PROJECT_FOLDER) && busted spec/ -c && luacov && luacov-cobertura -o cobertura.xml

package:
	luarocks make --pack-binary-rock

lint:
	cd $(PROJECT_FOLDER) && luacheck -q .
