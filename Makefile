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

mas_install:
WHICH_MAS := $(shell which mas > /dev/null; echo $$?)
	ifneq ($(WHICH_MAS),0)
		brew install mas
	endif

mas: mas_install
MAS_ACCOUNT := $(shell mas account > /dev/null; echo $$?)
	ifneq ($(MAS_ACCOUNT),0)
		$(error "You need to log in to the AppStore.")
	endif

bundle: brew mas ## Install brew and then brew bundle install
	brew bundle --file=Darwin/Brewfile install
	brew cleanup
	brew cask cleanup

homemaker_install:
WHICH_HOMEMAKER := $(shell which homemaker > /dev/null; echo $$?)
	ifeq ($(WHICH_HOMEMAKER),1)
		go get github.com/FooSoft/homemaker
	endif

submodules:
	git submodule update --init --remote

homemaker: homemaker_install submodules ## Run homemaker to build homedir
	homemaker --variant darwin --verbose homemaker.toml tilde/

setup: bundle homemaker ## Full computer setup with homedir and binaries

# Other targets
pre_commit: ## Install pre-commit hooks for this repo
	brew install pre-commit
	pre-commit install
