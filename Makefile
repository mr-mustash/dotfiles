update_submodules:
	git submodule update --remote
dotfiles:
	git submodule init
	git submodule update --remote
	rsync -rupE --copy-links --update --progress --exclude '.git' --exclude 'Makefile' --exclude 'README.md'  . ~/

dotfiles_test:
	mkdir -p ~/.homedirtest
	rsync -rupE --copy-links --update --progress --exclude '.git' --exclude 'Makefile' --exclude 'README.md'  . ~/.homedirtest/
	rm -rf ~/.homedirtest/
