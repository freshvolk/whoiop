#! /bin/bash

## Install homebrew and cask
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &&
brew install caskroom/cask/brew-cask

## Install Tools
init_tools=(fish erlang elixir git)

for item in ${init_tools[*]}
do
	echo "brew install $item > ${item}_brew.log"
	brew install $item > ${item}_brew.log
done

## Install casks
init_casks=(alfred dash google-chrome little-snitch visual-studio-code postrges steam bettertouchtool mpv macvim telegram iterm2 spotify)

for item in ${init_casks[*]}
do
	echo "brew cask install $item > ${item}_cask.log"
	brew cask install $item > ${item}_cask.log
done
