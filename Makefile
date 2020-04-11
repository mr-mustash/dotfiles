# Automatically update the repo
update_submodules:
	git submodule update --remote

update_brewfile:
	rm -rf Brewfile
	brew bundle dump
	sed -i '' '/newrelic/d' Brewfile
	git commit Brewfile "Updating Brewfile"

# Building my homedir, one piece at a time.
brew: mac_app_store
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
	brew upgrade
	brew bundle --file=Darwin/Brewfile install
	brew cleanup
	brew cask cleanup

mac_app_store:
	mas signin --dialog geek279@gmail.com

pre_commit:
	brew install pre-commit
	pre-commit install

darwin:
	./Darwin/defaults.sh

dotfiles:
	#MAKEFILE_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
	git submodule init
	git submodule update --remote
	rsync -rupE --copy-links --update --progress \
		--exclude='.git' \
		./tilde/ ~/

npm:
	npm install sign-bunny markcat

pip:
	pip3 install vim-vint gmail-yaml-filters

dotfiles_test:
	mkdir -p ~/.homedirtest
	git submodule init
	git submodule update --remote
	rsync -rupE --copy-links --update --progress \
		--exclude='.git' \
		./tilde/ ~/.homedirtest/

homedir:  brew npm pip pre_commit dotfiles

.PHONY: dotfiles dotfiles_test mac_app_store brew pre_commit npm pip darwin
