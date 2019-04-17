#!/usr/bin/env bash

# Update Homebrew
brew update --verbose
brew upgrade --display-times --verbose
brew cask upgrade --display-times --verbose
brew cleanup --verbose

# Update RubyGems
gem update -V
gem cleanup -V

# Update Node npm
npm cache clean -f

