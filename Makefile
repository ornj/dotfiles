# Setup local system and make it ready for primetime.

BREW_URL := "https://raw.githubusercontent.com/Homebrew/install/master/install"
DEST     := $(HOME)/

brew: brew-install brew-formulae brew-cask brew-cask-fonts brew-fuzzy-completion brew-cleanup

brew-install:
	/usr/bin/ruby -e "$$(/usr/bin/curl -fsSL $(BREW_URL))"

# Install Homebrew and formulae
brew-formulae:
	brew install autoconf pkg-config
	brew install \
		bash-completion \
		bat \
		cask \
		diff-so-fancy \
		docker-compose \
		git \
		fd \
		ffmpeg \
		fzf \
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
		yarn \
		zlib

# Install applications I use through brew cask
brew-cask:
	brew cask install \
		caffeine \
		docker \
		flux \
		google-chrome \
		iterm2 \
		skitch \
		slack \
		spectacle \
		spotify \
		tableplus \
		vlc \
		visual-studio-code

brew-cask-fonts:
	brew tap caskroom/fonts
	brew cask install font-inconsolata font-inconsolata-g-for-powerline

brew-fuzzy-completion:
	$(brew --prefix)/opt/fzf/install

brew-cleanup:
	brew cleanup

# Create .nvm directory if it doesn't already exist
setup-nvm:
	mkdir -p $(DEST)/.nvm

vscode: vscode-extensions vscode-settings

# Install vscode extensions
vscode-extensions:
	code \
    --install-extension andrejunges.Handlebars \
		--install-extension akamud.vscode-theme-onedark \
    --install-extension bajdzis.vscode-database \
    --install-extension christian-kohler.npm-intellisense \
		--install-extension DavidAnson.vscode-markdownlint \
		--install-extension eamodio.gitlens \
    --install-extension dbaeumer.vscode-eslint \
    --install-extension EditorConfig.EditorConfig \
    --install-extension esbenp.prettier-vscode \
    --install-extension flowtype.flow-for-vscode \
    --install-extension gerane.Theme-Flatgrammer \
    --install-extension gerane.Theme-Afterglow \
    --install-extension HookyQR.JSDocTagComplete \
    --install-extension jpoissonnier.vscode-styled-components \
    --install-extension kumar-harsh.graphql-for-vscode \
    --install-extension ms-python.python \
    --install-extension mohsen1.prettify-json \
    --install-extension msjsdiag.debugger-for-chrome \
		--install-extension ms-vscode.go \
    --install-extension PeterJausovec.vscode-docker \
    --install-extension QassimFarid.ejs-language-support \
    --install-extension shanoor.vscode-nginx \
    --install-extension waderyan.gitblame \
    --install-extension wholroyd.jinja

# Apply vscode user settings
vscode-settings:
	ln -hfsv $(PWD)/files/vscode.settings.json $(DEST)/Library/Application\ Support/Code/User/settings.json

# Create dotfiles in destination direcory
link:
	ln -hfsv $(PWD)/files/bash-powerline.sh $(DEST)/.bash-powerline.sh
	ln -hfsv $(PWD)/files/bash_profile $(DEST)/.bash_profile
	ln -hfsv $(PWD)/files/bashrc $(DEST)/.bashrc
	ln -hfsv $(PWD)/files/gitcompletion $(DEST)/.gitcompletion
	ln -hfsv $(PWD)/files/gitconfig $(DEST)/.gitconfig
	ln -hfsv $(PWD)/files/gitignore $(DEST)/.gitignore

# Do all the things
install: brew setup-nvm vscode link
