# Automatically update the repo
update_submodules:
	git submodule update --remote
	git commit -am "Updating submodules"

update_brewfile:
	rm -rf Brewfile
	brew bundle dump
	sed -i '' '/newrelic/d' Brewfile
	git commit Brewfile "Updating Brewfile"

# Building my homedir, one piece at a time.
brew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
	brew upgrade
	brew bundle install
	brew cleanup
	brew cask cleanup

mac_app_store:
	mas signin --dialog geek279@gmail.com

pre_commit:
	brew install pre-commit
	pre-commit install

darwin:
	./Darwin/darwin_setup.sh

dotfiles:
	#MAKEFILE_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
	git submodule init
	git submodule update --remote
	rsync -rupE --copy-links --update --progress \
		--exclude '.git' \
		--exclude '.gitmodules' \
		--exclude 'Makefile' \
		--exclude 'Brewfile' \
		--exclude 'README.md'  \
		--exclude 'Darwin' \
		. ~/

npm:
	npm install sign-bunny

pip:
	pip3 install vim-vint gmail-yaml-filters

dotfiles_test:
	mkdir -p ~/.homedirtest
	git submodule init
	git submodule update --remote
	rsync -rupE --copy-links --update --progress \
		--exclude '.git' \
		--exclude '.gitmodules' \
		--exclude 'Makefile' \
		--exclude 'Brewfile' \
		--exclude 'README.md'  \
		--exclude 'Darwin' \
		. ~/.homedirtest/

homedir:  brew npm pip pre_commit dotfiles

.PHONY: dotfiles dotfiles_test mac_app_store brew pre_commit npm pip darwin
