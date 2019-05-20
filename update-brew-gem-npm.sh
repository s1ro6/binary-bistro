#!/usr/bin/env bash

# Update Homebrew
brew update --verbose
brew upgrade --verbose
brew cask upgrade --verbose
brew cleanup --verbose

# Update RubyGems
gem update -V
gem cleanup -V

# Update Node npm
npm cache clean -f
npm install -g npm

