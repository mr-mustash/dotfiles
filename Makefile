update_submodules:
	git submodule update --remote
	git commit -am "Updating submodules"

update_brewfile:
	rm -rf Brewfile
	brew bundle dump
	sed -i '' '/newrelic/d' Brewfile
	git commit -am "Updating Brewfile"

brew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew bundle install

dotfiles:
	git submodule init
	git submodule update --remote
	rsync -rupE --copy-links --update --progress --exclude '.git' --exclude 'Makefile' --exclude 'README.md'  . ~/

dotfiles_test:
	mkdir -p ~/.homedirtest
	git submodule init
	git submodule update --remote
	rsync -rupE --copy-links --update --progress --exclude '.git' --exclude 'Makefile' --exclude 'README.md'  . ~/.homedirtest/
	rm -rf ~/.homedirtest/
