CURRENT_DIR:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include etc/make/variables.mk

# 🔝Main
.PHONY: default
default: info

.PHONY: info
info:
ifneq ($(OS),Windows_NT)
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
endif

.PHONY: build
build: deps start ## 🏗 Build app.

.PHONY: deps
deps: composer-install ## 🧩 Install Composer dependencies.

# 🐘 Composer
composer-env-file:
	@if [ ! -f .env.local ]; then echo '' > .env.local; fi

 .PHONY: composer-require
composer-require: DOCKER_COMMAND=require ## 🧩 Composer require.
composer-require: INTERACTIVE=--interactive --tty
composer-require: DOCKER_COMMAND_OPTIONS=--ignore-platform-reqs

 .PHONY: composer-update
composer-update: DOCKER_COMMAND=update ## 🧩 Composer update.
composer-update: INTERACTIVE=--interactive --tty
composer-update: DOCKER_COMMAND_OPTIONS=--ignore-platform-reqs

.PHONY: composer-require-dev
composer-require-dev: DOCKER_COMMAND=require --dev ## 🧩 Composer require dev.
composer-require-dev: INTERACTIVE=--interactive --tty
composer-require-dev: DOCKER_COMMAND_OPTIONS=--ignore-platform-reqs

.PHONY: composer-install
composer-install: DOCKER_COMMAND=install ## 🧩 Composer install.
composer-install: INTERACTIVE=--interactive --tty
composer-install: DOCKER_COMMAND_OPTIONS=--ignore-platform-reqs

.PHONY: composer-cache-clear
composer-cache-clear: DOCKER_COMMAND=run cache-clear ## 🧩 Symfony cache-clear.

.PHONY: composer
composer composer-install composer-require composer-require-dev composer-update: composer-env-file
	@docker run --rm $(INTERACTIVE) --volume $(CURRENT_DIR):/app --user $(id -u):$(id -g) \
		composer:2 $(DOCKER_COMMAND) \
			$(DOCKER_COMMAND_OPTIONS) \
			--no-ansi

# 🐳 Docker Compose
.PHONY: start
start: DOCKER_COMMAND=up -d  --build --force-recreate ## ▶️ Up containers.

.PHONY: restart
restart: DOCKER_COMMAND=restart ## ▶️ Restart containers.

.PHONY: stop
stop: DOCKER_COMMAND=stop ## ⏹ Stop containers.

.PHONY: destroy
destroy: DOCKER_COMMAND=down ## ⏹ Destroy containers.

.PHONY: status
status:DOCKER_COMMAND=ps ## 📈 Containers status

# Usage: `make doco DOCKER_COMMAND="ps --services"`
# Usage: `make doco DOCKER_COMMAND="build --parallel --pull --force-rm --no-cache"`
.PHONY: doco
doco start restart stop destroy status: composer-env-file
	USER_ID=${shell id -u} GROUP_ID=${shell id -g} docker-compose $(DOCKER_COMMAND)

.PHONY: rebuild
rebuild: composer-env-file
	docker-compose build --pull --force-rm --no-cache
	make deps
	make start
