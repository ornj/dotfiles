# Setup local system and make it ready for primetime.

BREW_URL := "https://raw.githubusercontent.com/Homebrew/install/master/install"
DEST     := $(HOME)/

brew: brew-install brew-formulae brew-cask brew-cask-fonts brew-link brew-cleanup

brew-install:
	/usr/bin/ruby -e "$$(/usr/bin/curl -fsSL $(BREW_URL))"

# Install Homebrew and formulae
brew-formulae:
	brew install \
		bash-completion \
		cask \
		diff-so-fancy \
		git \
		ffmpeg \
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
	brew cask install \
		1password \
		alfred \
		caffeine \
		docker \
		docker-completion \
		dropbox \
		flux \
		firefox \
		google-chrome \
		iterm2 \
		skitch \
		slack \
		sequel-pro \
		spectacle \
		spotify \
		trash \
		vlc \
		virtualbox \
		visual-studio-code
	brew cask alfred link

brew-cask-fonts:
	brew tap caskroom/fonts
	brew cask install font-inconsolata font-inconsolata-g-for-powerline

brew-link:
	brew linkapps --local

brew-cleanup:
	brew cleanup

# Create .nvm directory if it doesn't already exist
setup-nvm:
	mkdir -p $(DEST)/.nvm

vscode: vscode-extensions vscode-settings

# Install vscode extensions
vscode-extensions:
	code --install-extension DavidAnson.vscode-markdownlint \
	    --install-extension EditorConfig.EditorConfig \
	    --install-extension esbenp.prettier-vscode \
	    --install-extension HookyQR.JSDocTagComplete \
	    --install-extension PeterJausovec.vscode-docker \
	    --install-extension QassimFarid.ejs-language-support \
	    --install-extension andrejunges.Handlebars \
	    --install-extension bajdzis.vscode-database \
	    --install-extension christian-kohler.npm-intellisense \
	    --install-extension dbaeumer.vscode-eslint \
	    --install-extension donjayamanne.python \
	    --install-extension flowtype.flow-for-vscode \
	    --install-extension gerane.Theme-Flatgrammer \
	    --install-extension gerane.Theme-Afterglow \
	    --install-extension jpoissonnier.vscode-styled-components \
	    --install-extension kumar-harsh.graphql-for-vscode \
	    --install-extension mohsen1.prettify-json \
	    --install-extension msjsdiag.debugger-for-chrome \
	    --install-extension shanoor.vscode-nginx \
	    --install-extension waderyan.gitblame \
	    --install-extension wholroyd.jinja \
	    --install-extension zhuangtongfa.Material-theme

# Apply vscode user settings
vscode-settings:
	ln -hfsv $(PWD)/files/vscode.settings.json $(DEST)/Library/Application\ Support/Code/User/settings.json

# Create dotfiles in destination direcory
link:
	ln -hfsv $(PWD)/files/bash_powerline $(DEST)/.bash_powerline
	ln -hfsv $(PWD)/files/bash_profile $(DEST)/.bash_profile
	ln -hfsv $(PWD)/files/bashrc $(DEST)/.bashrc
	ln -hfsv $(PWD)/files/gitcompletion $(DEST)/.gitcompletion
	ln -hfsv $(PWD)/files/gitconfig $(DEST)/.gitconfig
	ln -hfsv $(PWD)/files/gitignore $(DEST)/.gitignore

# Do all the things
install: brew setup-nvm vscode link
