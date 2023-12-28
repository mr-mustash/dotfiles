.PHONY: help
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# homedir targets
brew:
WHICH_BREW := $(shell which brew > /dev/null; echo $$?)
	ifeq ($(WHICH_BREW),1)
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		brew update
		brew upgrade
	endif

bundle: brew  ## Install brew and then brew bundle install
	brew bundle --file=Darwin/Brewfile install
	brew cleanup
	brew cask cleanup

homemaker_install:
WHICH_HOMEMAKER := $(shell which homemaker > /dev/null; echo $$?)
	ifeq ($(WHICH_HOMEMAKER),1)
		GO111MODULE=on go install foosoft.net/projects/homemaker@latest
	endif

submodules:
	git submodule update --init --remote

homemaker: homemaker_install submodules ## Run homemaker to build homedir
	homemaker --variant darwin --verbose homemaker.toml tilde/


homedir: bundle homemaker ## Full computer setup with homedir and binaries

setup: bundle homemaker ## Full computer setup with homedir and binaries

# Other targets
docker: ## Build docker image
	docker build -t mrmustash/homedir:devel .

docker_clean: ## Build docker image without cache
	docker build --no-cache -t mrmustash/homedir:devel .

pre_commit: ## Install pre-commit hooks for this repo
	brew install pre-commit
	pre-commit install

pre_commit_update: ## Update pre-commit hooks for this repo
	pre-commit autoupdate
	pre-commit autoupdate --bleeding-edge --repo https://github.com/Kuniwak/vint
	pre-commit install --install-hooks
