#!/bin/bash

####################
# prep mac
####################
if [[ $(uname -s) == 'Darwin' ]]; then
	echo "========== Installing xcode cli development tools =========="
	xcode-select --install

	if [[ $(uname -m) == 'arm64' ]]; then
		echo "========== Installing rosetta =========="
		/usr/sbin/softwareupdate --install-rosetta --agree-to-license
	fi
fi

####################
# install homebrew
####################
echo "========== Set Homebrew path =========="
if [[ $(uname -m) == 'arm64' ]]; then
	export PATH=$PATH:/opt/homebrew/bin
elif [[ $(uname -m) == 'x86_64' ]]; then
	export PATH=$PATH:/usr/local/bin
fi

echo "========== Installing Homebrew =========="
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sudo chown -R "$(whoami)" "$(brew --prefix)"/*

####################
# install tools
####################
brew install fish zoxide exa starship mcfly

# Golang
echo "--- install golang ---"
brew install go

# Node
echo "--- install node ---"
brew install nvm
nvm install lts/hydrogen

npm install -g yarn

# Docker
brew install docker

####################
# config
####################
# fish config
mkdir -p "$HOME/.config/fish/conf.d"
cp fish/config.fish "$HOME/.config/fish/config.fish"
cp fish/shell.fish "$HOME/.config/fish/conf.d/shell.fish"

# starship config
cp starship/starship.toml "$HOME/.config/starship.toml"
