# Setup local system and make it ready for primetime.

BREW_URL := "https://raw.githubusercontent.com/Homebrew/install/master/install"
DEST     := $(HOME)/

# Install Homebrew and formulae
brew:
	/usr/bin/ruby -e "$$(/usr/bin/curl -fsSL $(BREW_URL))"
	brew install \
		bash-completion \
		cask \
		diff-so-fancy \
		git \
		htop-osx \
		httpie \
		hub \
		imagemagick \
		jq \
		nginx \
		node \
		nvm \
		openssl \
		pcre \
		pyenv \
		pyenv-virtualenv \
		sqlite \
		tldr \
		wget \
		yarn

# Install applications I use through brew cask
brew-cask:
	brew cask install /
		1password /
		docker /
		dropbox /
		firefox /
		google-chrome /
		iterm2 /
		slack /
		sequel-pro /
		spectacle /
		spotify /
		virtualbox /
		visual-studio-code

brew-cask-fonts:
	brew tap caskroom/fonts
	brew cask install font-inconsolata

# Create .nvm directory if it doesn't already exist
setup-nvm:
	mkdir -p $(DEST)/.nvm

# Create dotfiles in destination direcory
link:
	ln -hfsv $(PWD)/files/bash_powerline $(DEST)/.bash_powerline
	ln -hfsv $(PWD)/files/bash_profile $(DEST)/.bash_profile
	ln -hfsv $(PWD)/files/bashrc $(DEST)/.bashrc
	ln -hfsv $(PWD)/files/gitcompletion $(DEST)/.gitcompletion
	ln -hfsv $(PWD)/files/gitconfig $(DEST)/.gitconfig
	ln -hfsv $(PWD)/files/gitignore $(DEST)/.gitignore

# Do all the things
install: brew brew-cask brew-cask-fonts setup-nvm link
