# Automatically update the repo
update_submodules:
	git submodule update --remote
	git commit -am "Updating submodules"

update_brewfile:
	rm -rf Brewfile
	brew bundle dump
	sed -i '' '/newrelic/d' Brewfile
	git commit -am "Updating Brewfile"

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
	mas install 1055511498 #Day One
	mas install 585829637  #Todoist

dotfiles:
	git submodule init
	git submodule update --remote
	rsync -rupE --copy-links --update --progress --exclude '.git' --exclude 'Makefile' --exclude 'README.md'  . ~/

dotfiles_test:
	mkdir -p ~/.homedirtest
	git submodule init
	git submodule update --remote
	rsync -rupE --copy-links --update --progress --exclude '.git' --exclude 'Makefile' --exclude 'README.md'  . ~/.homedirtest/

homedir: dotfiles_test brew mac_app_store

.PHONY: dotfiles brew mac_app_store
